//package com.jam.controller;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.SessionAttribute;
//
//import com.jam.dto.EventDTO;
//import com.jam.repository.model.Event;
//import com.jam.repository.model.User;
//import com.jam.service.EventService;
//import com.jam.utils.Define;
//
//import jakarta.servlet.http.HttpSession;
//
//@Controller
//@RequestMapping("/event")
//public class EventController {
//
//	private final EventService eventService;
//	private final HttpSession session;
//	
//	// 생성자 
//	@Autowired
//	public EventController(HttpSession session, EventService eventService) {
//		this.session = session;
//		this.eventService = eventService;
//	}
//	/**
//	 * 전체 화면 출력 (페이징 처리)
//	 * @param page
//	 * @param size
//	 * @param model
//	 * @return
//	 */
//	@GetMapping("list")
//	public String eventListPage(@RequestParam(name="page" , defaultValue = "1")int page,
//			@RequestParam(name="size" , defaultValue = "10") int size, Model model) {
//	
//		int totalRecords = eventService.allList();
//		int totalPages = (int)Math.ceil((double)totalRecords/size);
//		List<Event> List = eventService.selectAllPage(page, size);
//		
//		
//		model.addAttribute("eventList" ,List);
//		model.addAttribute("currentPage" ,page);
//		model.addAttribute("totalPages" ,totalPages);
//		model.addAttribute("size" , size);
//		
//		return "/event/eventList";
//	}
//	
//	/**
//	 * insert 글쓰기 기능
//	 * @return
//	 */
//	@GetMapping("/write")
//	public String eventWritePage() {
//		return "/event/eventWrite";
//	}
//	
//	@PostMapping("write")
//	public String eventWrite(EventDTO dto,@SessionAttribute(Define.PRINCIPAL)User principal) {
//		eventService.eventWrite(dto, principal.getUserId());
//		return "redirect:/event/list";
//	}
//	
//	
//	
//	/**
//	 * 글 상세보기 
//	 * @return
//	 */
//	@GetMapping("detail/{eventId}")
//	public String eventDetailPage(@PathVariable(name="eventId") int eventId , Model model,
//			@SessionAttribute(Define.PRINCIPAL)User principal) {
//		
//		Event event = eventService.selectByEventId(eventId);
//		model.addAttribute("event" , event);
//		
//		return "/event/eventDetail";
//	}
//	
//	/**
//	 * delete 삭제 기능 
//	 */
//	@PostMapping("delete")
//	public String deleteEvent(@PathVariable(name="eventId")int eventId ,Model model) {
//		eventService.delete(eventId);
//		
//		return "redirect:/event/list";
//	}
//
//	
//	/**
//	 * 글 수정 기능
//	 */
//	@GetMapping("updatePage/{eventId}")
//	public String updatePage(@PathVariable(name="eventId") int eventId , Model model) {
//		Event event = eventService.selectByEventId(eventId);
//		model.addAttribute("event" ,event);
//		
//		return "/event/eventUpdate";
//	}
//	
//	
//	@PostMapping("update")
//	public String updateEvent(@RequestParam(name="eventId") int eventId , EventDTO dto) {
//		eventService.eventUpdate(dto, eventId);
//		return"redirect:/event/list";
//	}
//	
//}
package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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

   
}
