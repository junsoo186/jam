package com.jam.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
			@RequestParam("mFile") List<MultipartFile> mFiles, @RequestParam("bookId") Integer bookId,
			@RequestParam("rewards") String rewardsJson) {
		User principal = (User) session.getAttribute("principal");

		// Project 객체 생성 및 저장
		Project project = projectDTO.toProject(principal.getUserId(), bookId, principal.getNickName());

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
	@ResponseBody
	public List<Project> getProjects(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "16") int size) {
		List<Project> fundinList = fundingService.getPagedProjects(page, size); // 페이지 번호와 사이즈에 맞게 프로젝트 목록을 가져옴
		for (Project project : fundinList) {
			String mainImg = project.setUpMainImage();
			project.setMainImg(mainImg);
		}
		return fundinList;
	}

	@GetMapping("/projects")
	public String handleProjectList() {
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
			String fileUrl = "/images/funding/" + fileName;
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

	@PostMapping("/checkout")
	public String processCheckout(@RequestParam("totalAmount") int totalAmount,
			@RequestParam("rewardIds") List<String> rewardIdsStr, @RequestParam("quantities") List<Integer> quantities,
			HttpSession session) {

		List<Integer> rewardIds = rewardIdsStr.stream().map(Integer::parseInt).collect(Collectors.toList());

		System.out.println("totalAmount" + totalAmount);
		System.out.println("rewards : " + rewardIds.toString());
		System.out.println("quantities : " + quantities.toString());

		// 세션에 데이터 저장
		session.setAttribute("totalAmount", totalAmount);
		session.setAttribute("rewardIds", rewardIds);
		session.setAttribute("quantities", quantities);

		return "redirect:/funding/checkoutPage";
	}

	@GetMapping("/checkoutPage")
	public String checkoutPage(HttpSession session, Model model) {
		Integer totalAmount = (Integer) session.getAttribute("totalAmount");
		List<Integer> rewardIds = (List<Integer>) session.getAttribute("rewardIds");
		List<Integer> quantities = (List<Integer>) session.getAttribute("quantities");

		if (totalAmount == null || rewardIds == null || quantities == null) {
			return "redirect:/errorPage";
		}

		List<Reward> rewards = new ArrayList<>();
		for (Integer rewardId : rewardIds) {
			Reward reward = fundingService.findRewardByRewardId(rewardId);
			if (reward != null) {
				rewards.add(reward);
			} else {
				System.out.println("reward");
				return "redirect:/errorPage";
			}
		}

		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("rewards", rewards);
		model.addAttribute("quantities", quantities);

		return "funding/checkoutPage";
	}

	@PostMapping("/checkoutPage")
	public String processCheckout(@RequestParam("totalAmount") int totalAmount,
			@RequestParam("rewardIds") List<Integer> rewardIds, @RequestParam("quantities") List<Integer> quantities,
			@RequestParam("postcode") String postcode, @RequestParam("basicAddress") String basicAddress,
			@RequestParam("detailedAddress") String detailedAddress, @RequestParam("extraAddress") String extraAddress,
			Model model) {

		User principal = (User) session.getAttribute("principal");

		// 각각의 리워드와 수량에 대해 처리
		for (int i = 0; i < rewardIds.size(); i++) {
			Integer rewardId = rewardIds.get(i);
			Integer quantity = quantities.get(i);

			// 각각의 리워드에 대한 펀딩 생성
			Funding funding = Funding.builder().userId(principal.getUserId()).rewardId(rewardId) // 리스트에서 각 리워드 ID
					.rewardQuantity(quantity) // 해당 리워드에 대한 수량
					.zipcode(postcode).basicAddress(basicAddress).detailedAddress(detailedAddress)
					.extraAddress(extraAddress).build();
			fundingService.insertFunding(funding);
		}
		fundingService.usePointByFunding(principal.getUserId(), totalAmount);

		return "redirect:/funding/fundingDetail";
	}

	@PostMapping("/cancelFunding")
	public ResponseEntity<String> cancelFunding(@RequestBody Map<String, Object> requestData) {
		Integer fundingId = (Integer) requestData.get("fundingId");
		Integer totalAmount = (Integer) requestData.get("totalAmount");
		User principal = (User) session.getAttribute("principal");

		// 펀딩 취소 로직 실행
		try {
			fundingService.cancelFunding(fundingId, totalAmount, principal.getUserId()); // 서비스에서 취소 처리
			return ResponseEntity.ok("펀딩 취소 성공");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("펀딩 취소 실패");
		}
	}

}
