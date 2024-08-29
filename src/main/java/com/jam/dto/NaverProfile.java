package com.jam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class NaverProfile {
	
	 private String resultcode;
	 private String message;
	 private NaverProfileResponse response;  // 내부 객체
	
	
   
   
   
}
