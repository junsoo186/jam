package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jam.repository.model.Event;
import com.jam.service.EventService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/event")
public class EventController {

    private final EventService eventService;
    private final HttpSession session;
    
    @Autowired
    public EventController(HttpSession session, EventService eventService) {
        this.session = session;
        this.eventService = eventService;
    }


	
    @GetMapping("list")
    public String eventListPage(@RequestParam(name="page", defaultValue = "1") int page,
                                @RequestParam(name="size", defaultValue = "10") int size, 
                                Model model) {
        int totalRecords = eventService.allList();
        int totalPages = (int) Math.ceil((double) totalRecords / size);
        List<Event> list = eventService.selectAllPage(page, size);

        model.addAttribute("eventList", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
        
        return "/event/eventList";
    }
    
    /**
	 * 글 상세보기 
	 * @return
	 */
    @GetMapping("/detail/{eventId}")
    public String eventDetailPage(@PathVariable("eventId") int eventId, Model model) {
        Event event = eventService.selectByEventId(eventId);
        event.setEventImage(event.setUploadEventImage());
        model.addAttribute("event", event); // 이벤트 객체를 모델에 추가
        return "event/eventDetail"; // JSP 파일 경로
    }

   
}
