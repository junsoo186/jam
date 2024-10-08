package com.jam.dto;

import java.time.LocalDate;

import com.jam.repository.model.Event;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class EventDTO {
	
	private int eventId;
	private String eventTitle;
	private String eventContent;
	private LocalDate startDay;
	private LocalDate endDay;
	private int limit;
	private int offset;
	
	public Event toEvent(int eventId) {
	    return Event.builder()
	        .eventId(eventId)
	        .eventTitle(this.eventTitle)  // 이벤트 제목 변환
	        .eventContent(this.eventContent)  // 이벤트 내용 변환
	        .startDay(this.startDay)  // 이벤트 시작일 변환
	        .endDay(this.endDay)  // 이벤트 종료일 변환
	        .build();
	}
	
	public Event toEventInsertUserId(int userId) {
	    return Event.builder()
	        .userId(userId)
	        .eventTitle(this.eventTitle)  // 이벤트 제목 변환
	        .eventContent(this.eventContent)  // 이벤트 내용 변환
	        .startDay(this.startDay)  // 이벤트 시작일 변환
	        .endDay(this.endDay)  // 이벤트 종료일 변환
	        .build();
	}


}
