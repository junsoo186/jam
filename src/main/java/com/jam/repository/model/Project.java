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
public class Project {

	private Integer projectId;
	private String author;
	private String title;
	private String contents;
	private Integer categoryId;
	private Integer collectedAmount; // 현재 모금액
	private Integer goal; // 목표 금액
	private Date dateEnd;
	private String projectImage;
	private Timestamp createdAt;
	private String staffAgree;
}
