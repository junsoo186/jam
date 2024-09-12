package com.jam.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jam.dto.ProjectDTO;
import com.jam.dto.RewardDTO;
import com.jam.repository.model.Book;
import com.jam.repository.model.Content;
import com.jam.repository.model.Funding;
import com.jam.repository.model.Project;
import com.jam.repository.model.Reward;
import com.jam.repository.model.User;
import com.jam.service.FundingService;
import com.jam.service.UserService;
import com.jam.service.WriterService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@RequestMapping("/funding")
@RequiredArgsConstructor
public class FundingController {

	private final HttpSession session;
	private final FundingService fundingService;
	private final WriterService writerService;
	private final UserService userService;

	@Value("${file.upload-dir}")
	private String uploadDir;

	/**
	 * 
	 * @param bookId
	 * @param model
	 * @return
	 */
	@GetMapping("/createFunding")
	public String handleFundingPage(@RequestParam("bookId") Integer bookId, Model model) {
		User principal = (User) session.getAttribute("principal");
		Book book = writerService.findBookByBookId(bookId);

		model.addAttribute("book", book);
		model.addAttribute("principal", principal);
		return "funding/createFunding";
	}

	/**
	 * 
	 * @param projectDTO
	 * @param mainMFile
	 * @param mFiles
	 * @param bookId
	 * @param rewardsJson
	 * @return
	 */
	@PostMapping("/createFunding")
	public ResponseEntity<Map<String, Object>> createFunding(@ModelAttribute ProjectDTO projectDTO,
			@RequestParam("mFile") List<MultipartFile> mFiles,
			@RequestParam("bookId") Integer bookId, @RequestParam("rewards") String rewardsJson) {
		User principal = (User) session.getAttribute("principal");

		// Project 객체 생성 및 저장
		Project project = projectDTO.toProject(principal.getUserId(), bookId, principal.getNickName(), mainMFile);

		// 리워드 데이터를 JSON 문자열로 받아서 파싱
		ObjectMapper objectMapper = new ObjectMapper();
		List<RewardDTO> rewards = new ArrayList<>();
		try {
			rewards = objectMapper.readValue(rewardsJson, new TypeReference<List<RewardDTO>>() {
			});
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		// 서비스 호출하여 프로젝트와 리워드, 파일 저장
		fundingService.insertProject(project, rewards, mFiles);

		// 생성된 projectId를 반환
		System.out.println("projectId : " + project.getProjectId());
		Map<String, Object> response = new HashMap<>();
		response.put("projectId", project.getProjectId());

		return ResponseEntity.ok(response); // JSON 형식으로 projectId 반환
	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/fundingList")
	public String handleFundingList(Model model) {
		List<Project> projects = fundingService.findAllProject();

		for (Project project : projects) {
			project.setMainImg(project.setUpMainImage()); // 바로 설정
		}
		model.addAttribute("projectList", projects);

		return "funding/fundingList";
	}

	/**
	 * 
	 * @param projectId
	 * @param model
	 * @return
	 */
	@GetMapping("/fundingDetail")
	public String fundingDetail(@RequestParam("projectId") Integer projectId, Model model) {
		// projectId로 프로젝트 상세 정보 조회
		Project project = fundingService.findDetailProject(projectId);
		List<Reward> rewards = fundingService.findRewardByProjectId(projectId);
		List<Content> projectImgs = fundingService.findAllProjectImgByProjectId(projectId);

		String mainImg = project.setUpMainImage();
		project.setMainImg(mainImg);

		for (Content img : projectImgs) {
			String projectImg = img.setUpImage();
			img.setImg(projectImg);
		}

		model.addAttribute("project", project);
		model.addAttribute("rewards", rewards);
		model.addAttribute("projectImgs", projectImgs);

		return "funding/fundingDetail"; // 상세 페이지로 이동
	}

	/**
	 * 
	 * @param projectId
	 * @return
	 */
	@GetMapping("/updateFunding")
	public String getMethodName(@RequestParam("projectId") Integer projectId, Model model) {
		Project project = fundingService.findProjectByProjectId(projectId);
		List<Reward> rewards = fundingService.findRewardByProjectId(projectId);
		List<Content> projectImgs = fundingService.findAllProjectImgByProjectId(projectId);

		for (Content img : projectImgs) {
			String projectImg = img.setUpImage();
			img.setImg(projectImg);
		}

		model.addAttribute("project", project);
		model.addAttribute("rewards", rewards);
		model.addAttribute("projectImg", projectImgs);
		return "funding/fundingUpdate";
	}

	/**
	 * 
	 * @param projectId
	 * @return
	 */
	@PostMapping("/updateFunding")
	public ResponseEntity<Map<String, Object>> updateFundingProc(@RequestParam("projectId") Integer projectId,
			@ModelAttribute ProjectDTO projectDTO, @RequestParam("rewards") String rewardsJson,
			@RequestParam("mFile") List<MultipartFile> mFiles) {
		try {
			fundingService.updateProject(projectDTO, projectId, mFiles);

			ObjectMapper objectMapper = new ObjectMapper();
			List<RewardDTO> rewards = new ArrayList<>();
			try {
				rewards = objectMapper.readValue(rewardsJson, new TypeReference<List<RewardDTO>>() {
				});
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}

			fundingService.updateReward(rewards, projectId);

			Map<String, Object> response = new HashMap<>();
			response.put("projectId", projectId);

			// 실제 데이터 저장 로직이 성공하면
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	/**
	 * 
	 * @param file
	 * @return
	 */
	@PostMapping("/image")
	public ResponseEntity<Map<String, Object>> uploadImage(@RequestParam("upload") MultipartFile file) {
		Map<String, Object> response = new HashMap<>();
		try {
			// 파일 저장 경로 설정
			String fileName = UUID.randomUUID() + file.getOriginalFilename();
			Path filePath = Paths.get(uploadDir, fileName);

			// 파일을 저장할 디렉토리가 존재하는지 확인 후 생성
			if (!Files.exists(filePath.getParent())) {
				Files.createDirectories(filePath.getParent());
			}

			// 파일 저장
			Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

			// 저장된 파일의 URL 생성
			String fileUrl = "/images/uploads/" + fileName;
			System.out.println("fileUrl" + fileUrl);
			// CKEditor에서 요구하는 응답 형식
			response.put("uploaded", true);
			response.put("url", fileUrl);

			return new ResponseEntity<>(response, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			response.put("uploaded", false);
			response.put("error", Map.of("message", "파일 업로드 중 오류가 발생했습니다."));
			return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 기존 이미지 삭제
	 * 
	 * @param imgId
	 * @return
	 */
	@DeleteMapping("/deleteImage")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deleteImage(@RequestParam("imgId") Integer imgId) {
		Map<String, Object> response = new HashMap<>();

		try {
			// 이미지 삭제 서비스 호출
			fundingService.deleteProjectImage(imgId);
			response.put("success", true);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "이미지 삭제에 실패했습니다.");
		}

		return ResponseEntity.ok(response);
	}

	@PostMapping("/funding/selectReward")
	@ResponseBody
	public Map<String, Object> selectReward(@RequestBody RewardDTO rewardDTO) {
		Map<String, Object> response = new HashMap<>();

		// rewardSelection DTO에서 userId와 reward 정보를 처리
		boolean success = fundingService.insertRewardByUserId(rewardDTO.getUserId(), rewardDTO.getRewardId());

		if (success) {
			response.put("success", true);
		} else {
			response.put("success", false);
		}

		return response;
	}

	@PostMapping("/funding/checkout")
	@ResponseBody
	public Map<String, Object> processCheckout(@RequestBody Map<String, Object> checkoutData) {
		// 결제 처리 로직 추가
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message", "결제가 성공적으로 처리되었습니다.");
		return response;
	}

	@GetMapping("/checkoutPage")
	public String checkoutPage(@RequestParam("totalAmount") int totalAmount,
			@RequestParam("cartItems") String cartItemsJson,
			Model model) throws Exception {
		// JSON 문자열을 객체로 변환하여 모델에 추가
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String, Object>> cartItems = objectMapper.readValue(cartItemsJson, List.class);

		System.out.println(cartItems);

		// 결제 확인 페이지로 데이터 전달
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("cartItems", cartItems);

		return "/funding/checkoutPage"; // 결제 확인 페이지
	}

	@PostMapping("/checkout")
	@ResponseBody
	public Map<String, Object> checkoutAjax(@RequestBody Map<String, Object> requestData) {
		int totalAmount = (Integer) requestData.get("totalAmount");
		String postcode = (String) requestData.get("postcode");
		String basicAddress = (String) requestData.get("basicAddress");
		String detailedAddress = (String) requestData.get("detailedAddress");
		String extraAddress = (String) requestData.get("extraAddress");
		List<Map<String, Object>> cartItems = (List<Map<String, Object>>) requestData.get("cartItems");

		Map<String, Object> response = new HashMap<>();

		try {
			// 1. 유저 정보 가져오기
			User principal = (User) session.getAttribute("principal");
			int userId = principal.getUserId(); // 세션에서 유저 정보를 가져오는 로직 (예시)

			// 3. 장바구니 데이터 검증 및 결제 데이터 저장
			for (Map<String, Object> item : cartItems) {
				int rewardId = Integer.parseInt(item.get("rewardId").toString());
				int quantity = Integer.parseInt(item.get("quantity").toString());
				String shippingAddress = basicAddress + " " + detailedAddress + " " + extraAddress;

				// 결제 정보 저장 (funding_tb 테이블에 삽입)
				Funding funding = Funding.builder()
						.userId(userId)
						.rewardId(rewardId)
						.rewardQuantity(quantity)
						.zipcode(postcode)
						.basicAddress(basicAddress)
						.detailedAddress(detailedAddress)
						.extraAddress(extraAddress)
						.createdAt(new Timestamp(System.currentTimeMillis()))
						.canceledAt(null)
						.confirmSuccess("N") // 초기에는 'N' 상태
						.build();

				// 실제 데이터베이스에 저장
				fundingService.insertFunding(funding);
			}

			// 4. 유저 포인트 차감
			userService.updateUserPoints(userId, principal.getPoint() - totalAmount);

			// 5. 성공 응답 반환
			response.put("success", true);
			response.put("message", "결제가 완료되었습니다.");

		} catch (Exception e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "결제 처리 중 오류가 발생했습니다.");
		}

		return response;
	}

}