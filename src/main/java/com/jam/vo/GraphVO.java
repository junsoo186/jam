package com.jam.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GraphVO {

	private int userId;
	private String nickName;
	private String email;
	private String phoneNumber;
	private String profileImg;

}
