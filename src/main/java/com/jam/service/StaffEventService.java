//package com.jam.service;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.jam.dto.EventDTO;
//import com.jam.repository.interfaces.EventRepository;
//import com.jam.repository.model.Event;
//
//@Service
//public class EventService {
//
//	private final EventRepository eventRepository;
//	
//	public EventService(EventRepository eventRepository) {
//		this.eventRepository = eventRepository;
//	}
//	
//	// 이벤트 글쓰기
//	@Transactional
//	public void eventWrite(EventDTO dto, int userId) {
//		int result = 0;
//		result = eventRepository.insertE(dto.toEvent(userId));
//	}
//	
//	// 글 상세보기
//	public Event selectByEventId(int eventId) {
//		Event event = eventRepository.selectByEventId(eventId);
//		return event;
//	}
//	
//	// 전체 페이징 
//	public List<Event> selectAllPage(int page , int size) {
//		List<Event> list = new ArrayList<>();
//		int limit = size;
//		int offset = (page - 1) * size;
//		list = eventRepository.selectAllPage(limit , offset);
//		return list;
//	}
//	
//	// 페이징 처리 및 전체 리스트 숫자 확인 
//	public int allList() {
//		return eventRepository.countAll();
//	}
//	
//	// 글 삭제
//	@Transactional
//	public void delete(int eventId){
//	int result  = 0 ;
//	result = eventRepository.deleteE(eventId);
//	}
//	
//	// 글 수정
//	public int eventUpdate(EventDTO dto , int eventId) {
//		int result = eventRepository.updateE(eventId ,dto.getEventTitle(),dto.getEventContent(),dto.getStartDay(),dto.getEndDay());
//		return result;
//	}
//	
//}
package com.jam.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jam.dto.EventDTO;
import com.jam.repository.interfaces.StaffEventRepository;
import com.jam.repository.model.Event;

@Service
public class StaffEventService {

	private final StaffEventRepository staffEventRepository;

	public StaffEventService(StaffEventRepository staffEventRepository) {
		this.staffEventRepository = staffEventRepository;
	}

	@Transactional
	public void eventWrite(EventDTO dto, int userId) {
		staffEventRepository.insertE(dto.toEvent(userId));
	}

	public Event selectByEventId(int eventId) {
		return staffEventRepository.selectByEventId(eventId);
	}

	public List<Event> selectAllPage(int page, int size) {
		int limit = size;
		int offset = (page - 1) * size;
		return staffEventRepository.selectAllPage(limit, offset);
	}

	public int allList() {
		return staffEventRepository.countAll();
	}

	@Transactional
	public void delete(int eventId) {
		staffEventRepository.deleteE(eventId);
	}

	public int eventUpdate(EventDTO dto, int eventId) {
		return staffEventRepository.updateE(eventId, dto.getEventTitle(), dto.getEventContent(), dto.getStartDay(),
				dto.getEndDay());
	}
}
