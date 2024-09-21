package com.jam.repository.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
public class Event {

	private int eventId;
	private String eventTitle;
	private String eventContent;
	private Timestamp createdAt;
	private LocalDate startDay;
	private LocalDate endDay;
	private int userId;
	private int limit;
	private int offset;
	private String eventImage;

	
	 public String setUploadEventImage() {
			if (eventImage == null) {
				return "/images/cover/winterCover.jpg";
			} else {
				return "/images/" + eventImage;
			}
		}
	    
}
