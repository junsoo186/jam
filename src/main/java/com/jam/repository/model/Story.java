package com.jam.repository.model;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Story {

	private Integer storyId;
	private Integer bookId;
	private Integer userId;
	private Integer number;
	private String type;
	private String title;
	private Date uploadDay; // 예약 업로드 날짜
	private Timestamp createdAt;
	private String save;
	private Integer cost;
	private Integer views;
	private String content;
}
