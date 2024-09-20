package com.jam.repository.model;

import com.jam.dto.MainBannerDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Data
@Builder
public class MainBanner {

	int mainBannerId;
	String title;
	String content;
	String subContent;
	String imagePath;
	int eventId;
	
    public String setUpUserImage() {
		if (imagePath == null) {
			return "/images/cover/winterCover.jpg";
		} else {
			return "/images/" + imagePath;
		}
	}
    
}
