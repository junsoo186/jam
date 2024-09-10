package com.jam.dto;

import java.sql.Date;
import java.sql.Timestamp;

import com.jam.repository.model.Project;

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
public class ProjectDTO {
	
	private int projectId;
    private int userId; 
    private int rewardId; 
    private int bookId; 
    private String title; // 프로젝트 제목
    private String contents; // 프로젝트 내용
    private long goal; // 목표 금액
    private Date dateEnd; // 마감일
    private Timestamp createdAt; 
    private String staffAgree; // Enum ('N', 'Y') || 스태프 승인 여부 (기본은 N)
    private String projectImg; // 프로젝트 이미지
    private String onelineComment; // 프로젝트 1줄 소개 (목록에서 출력)
    private String categoryName; // 카테고리 종류
    private long currentAmount; // 현제 모인 금액
    
    public Project toProject(Integer userId, Integer bookId, String author) {
    	return Project.builder()
    			.userId(userId)
    			.bookId(bookId)
    			.author(author)
    			.title(this.title)
    			.contents(this.contents)
    			.goal(this.goal)
    			.dateEnd(this.dateEnd)
    			.projectImg(this.projectImg)
    			.onelineComment(this.onelineComment)
    			.currentAmount(this.currentAmount)
    			.build();
    }
}
