package com.jam.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

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
	
	
	@GetMapping("list")
	public String eventListPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size, Model model) {
		int totalRecords = staffEventService.allList();
		int totalPages = (int) Math.ceil((double) totalRecords / size);
		List<Event> list = staffEventService.selectAllPage(page, size);
		model.addAttribute("eventList", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("size", size);

		return "staff/event";
	}

	@GetMapping("/content-management")
	public String handleContentManage() {
		return "staff/content-management";
	}

	@GetMapping("/qna")
	public String handleQna() {
		return "staff/qna";
	}

	@GetMapping("/notice")
	public String handleNotice() {
		return "staff/notice";
	}

	@GetMapping("/reportContentDetail")
	public String handleReportContentDetail() {
		return "staff/reportContentDetail";
	}

	@GetMapping("/reportUserDetail")
	public String handleReportUserDetail() {
		return "staff/reportUserDetail";
	}

	@GetMapping("/payDetail")
	public String handlePayDetail() {
		return "staff/payDetail";
	}

	@GetMapping("/donationDetail")
	public String handleDonationDetail() {
		return "staff/donationDetail";
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

	@PostMapping("delete")
	public String deleteEvent(@RequestParam(name = "eventId") int eventId) {
		staffEventService.delete(eventId);
		return "redirect:/staff/list";
	}

	@GetMapping("updatePage/{eventId}")
	public String updatePage(@PathVariable(name = "eventId") int eventId, Model model) {
		Event event = staffEventService.selectByEventId(eventId);
		model.addAttribute("event", event);
		return "/staff/eventUpdate";
	}

	@PostMapping("update")
	public String updateEvent(@RequestParam(name = "eventId") int eventId, EventDTO dto) {
		staffEventService.eventUpdate(dto, eventId);
		return "redirect:/staff/list";
	}
	
	
	
	
	
	
	
	
	
	

}
