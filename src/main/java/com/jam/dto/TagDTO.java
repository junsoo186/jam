package com.jam.dto;

import java.sql.Date;

import com.jam.repository.model.Tag;

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
public class TagDTO {
	
	private Integer tagId;
	private String tagName;
	
	public Tag toTag() {
		return Tag.builder()
				.tagId(this.tagId)
				.tagName(this.tagName)
				.build();
	}
}
