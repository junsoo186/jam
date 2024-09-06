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
@Builder
@ToString
public class User {
	
	private Integer userId;
	private String name;
	private Date birthDate;
	private String gender;
	private String address;
	private String nickName;
	private String phoneNumber;
	private String email;
	private String password;
	private long point;
	private String role;
	private Timestamp createdAt;
	private String profileImg;
	private String oriProfileImg;
	
	public String setUpUserImage() {
		if (profileImg == null) {
			return "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbCXLP7%2FbtrQuNirLbt%2FN30EKpk07InXpbReKWzde1%2Fimg.png";
		} else {
			return "/images/uploads/" + profileImg;
		}
	}
}
