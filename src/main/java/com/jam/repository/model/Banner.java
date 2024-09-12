package com.jam.repository.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Banner {
	   private int bannerId;
	   private String title;
	   private String contentOne;
	   private String contentTwo;
	   private String img;
	   private int eventId;	
}
