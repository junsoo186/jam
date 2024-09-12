package com.jam.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jam.repository.interfaces.EventRepository;
import com.jam.repository.model.Event;
@Service
public class EventService {
	
	private final EventRepository eventRepository;
	
	
	public EventService(EventRepository eventRepository) {
		this.eventRepository = eventRepository;
	}
	
	public List<Event> selectAllPage(int page, int size) {
		int limit = size;
		int offset = (page - 1) * size;
		return eventRepository.selectAllPage(limit, offset);
	}

	public Event selectByEventId(int eventId) {
		return eventRepository.selectByEventId(eventId);
	}

	public int allList() {
		return eventRepository.countAll();
	}
}
