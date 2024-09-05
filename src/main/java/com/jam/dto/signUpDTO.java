package com.jam.dto;

import org.springframework.web.multipart.MultipartFile;

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
public class signUpDTO {

	private String nickName;
	private String phoneNumber;
	private String email;
	private String password;
	private String role;
	private MultipartFile mFile;
	private String profileImg;
	private String oriProfileImg;
	
	
	public User toUser() {
		return User.builder()
				.nickName(this.nickName)
				.phoneNumber(this.phoneNumber)
				.email(this.email)
				.password(this.password)
				.role(this.role)
				.profileImg(this.profileImg)
				.oriProfileImg(this.oriProfileImg)
				.build();
	}
	
	public signInDTO toSignInDTO() {
		return signInDTO.builder()
				.email(this.email)
				.password(this.password)
				.build();
		
	}
	
	
	
}
