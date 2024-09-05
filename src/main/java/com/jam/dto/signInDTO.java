package com.jam.dto;

import com.jam.repository.model.User;

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
public class signInDTO {
	
	private int userId;
	private String email;
	private String password;
	
	public User toUser() {
		return User.builder()
				.email(this.email)
				.password(this.password)
				.build();
	}
}
