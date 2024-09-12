package com.jam.repository.model;

import java.sql.Date;
import java.sql.Timestamp;

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
	private Date startDay;
	private Date endDay;
	private int userId;
	private int limit;
	private int offset;
	
}
