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
	
	private String name;
	private Date birthDate;
	private String gender;
	private String address;
	private String nickName;
	private String phoneNumber;
	private String email;
	private String password;
	private String role;
	private String adminCheck;
	private Timestamp createdAt;


}
