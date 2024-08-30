package com.jam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserDTO {

	private Integer userId;
	private String name;
	private String nickname;
	private String email;
	private String password;
	
	
}
