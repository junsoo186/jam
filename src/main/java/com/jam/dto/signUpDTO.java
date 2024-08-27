package com.jam.dto;

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
public class signUpDTO {
	
	private String name;
	private String birthDate;
	private String gender;
	private String address;
	private String nickname;
	private String phoneNumber;
	private String email;
	private String password;
	private String adminCheck;
	
	
	
}
