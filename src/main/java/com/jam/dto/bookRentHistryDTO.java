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
public class bookRentHistryDTO {
	// book_rent_histry_tb
	private int book_rent_history_id; // AUTO_INCREMENT
	private int user_id; // 유저 아이디 - user_tb
	private int book_id; // 책 아이디 - book_tb
	private int story_id; // 책 내용 아이디 - book_tb
	private int account_amount; // 구매 포인트
	private int before_point; // 사용자 보유 포인트
	private int after_point; // 사용자 구매 후 포인트	
}
