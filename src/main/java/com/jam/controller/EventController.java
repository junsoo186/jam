package com.jam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.jam.repository.model.User;
import com.jam.service.EventService;
import com.jam.utils.Define;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/event")
public class EventController {

	@Autowired

	@GetMapping("list")
	public String eventListPage() {

		return "/event/eventList";
	}

	@GetMapping("detail")
	public String eventDetailPage() {
		return "/event/eventDetail";
	}

}
