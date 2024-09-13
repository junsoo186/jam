package com.jam.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.jam.dto.EventDTO;
import com.jam.repository.model.Event;
import com.jam.repository.model.User;
import com.jam.service.StaffEventService;
import com.jam.utils.Define;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/staffEvent")
@RequiredArgsConstructor
public class StaffEventController {
	
	private final StaffEventService staffEventService;
	
	
	@GetMapping("")
	public String handleStaffMain(@RequestParam(name = "page", required = false) String page, Model model) {
		String sectionUrl = "/staff/" + page;
		model.addAttribute("sectionUrl", sectionUrl);
		return "staff/main";
	}
	
	@GetMapping("list")
	public String eventListPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size, Model model,@SessionAttribute(Define.PRINCIPAL) User principal) {
		int totalRecords = staffEventService.allList();
		int totalPages = (int) Math.ceil((double) totalRecords / size);
		List<Event> list = staffEventService.selectAllPage(page, size);
	
		model.addAttribute("eventList", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("size", size);

		return "staff/event";
	}


	@GetMapping("/write")
	public String eventWritePage() {
		return "/staff/eventWrite";
	}

	@PostMapping("write")
	public String eventWrite(EventDTO dto, @SessionAttribute(Define.PRINCIPAL) User principal) {
	    // DTO의 eventTitle이 null이거나 빈 문자열인지 먼저 확인
	    if (dto.getEventTitle() == null || dto.getEventTitle().isEmpty()) {
	        throw new IllegalArgumentException("Event Title cannot be null or empty");
	    }
	    // 검증 후 이벤트 저장 처리
	    staffEventService.eventWrite(dto, principal.getUserId());
	    
	    return "redirect:/staffEvent/list";
	}


	@GetMapping("detail/{eventId}")
	public String eventDetailPage(@PathVariable(name = "eventId") int eventId, Model model) {
		Event event = staffEventService.selectByEventId(eventId);
		model.addAttribute("event", event);
		return "/staff/eventDetail";
	}

	@GetMapping("delete/{eventId}")
	public String deleteEvent(@PathVariable(name = "eventId")Integer eventId) {
		staffEventService.delete(eventId);
		return "redirect:/staff?page=event";
	}

	@PostMapping("delete/{eventId}")
	public String delete(@PathVariable(name = "noticeId") Integer noticeId) {
		staffEventService.delete(noticeId);
		return "redirect:/staff?page=event";
	}
	
	@GetMapping("update/{eventId}")
	public String updatePage(@PathVariable(name = "eventId") int eventId, Model model) {
		Event event = new Event();
		event = staffEventService.selectByEventId(eventId);
		model.addAttribute("event", event);
		return "/staff/eventUpdate";
	}

	@PostMapping("update/{eventId}")
	public String updateEvent(@RequestParam(name = "eventId") int eventId, EventDTO dto) {
		staffEventService.eventUpdate(dto, eventId);
		return "redirect:/staff?page=event";
	}
	
//	/*
//	 *  이미지 업로드
//	 */
//	// application.properties에서 설정한 경로를 가져옵니다.
//	@Controller
//	public class FileUploadController {
//
//	    // application.properties에서 설정한 경로를 가져옵니다.
//	    @Value("${file.upload-dir}")
//	    private String uploadDir;
//
//	    @PostMapping("/uploadImage")
//	    public ResponseEntity<?> uploadImage(@RequestParam("upload") MultipartFile file) {
//	        try {
//	            // 파일 이름을 깨끗하게 정리
//	            String fileName = file.getOriginalFilename();
//
//	            // 업로드 경로가 존재하지 않으면 디렉토리를 생성
//	            Path uploadPath = Paths.get(uploadDir);
//	            if (!Files.exists(uploadPath)) {
//	                Files.createDirectories(uploadPath);
//	            }
//
//	            // 파일을 저장할 경로 생성
//	            try (InputStream inputStream = file.getInputStream()) {
//	                Path filePath = uploadPath.resolve(fileName);
//	                Files.copy(inputStream, filePath);
//	            }
//
//	            // 업로드된 파일의 URL 반환
//	            String imageUrl = "/images/uploads/" + fileName; // 실제로 이미지 파일을 참조하는 URL
//	            return ResponseEntity.ok("{\"url\":\"" + imageUrl + "\"}");
//
//	        } catch (IOException e) {
//	            e.printStackTrace();
//	            return ResponseEntity.status(500).body("파일 업로드 실패");
//	        }
//	    }
//	}
//	
	
}