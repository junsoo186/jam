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

	private String nickName;
	private String phoneNumber;
	private String email;
	private String password;
	private String role;
	
	
	
}
