package com.jam.dto;

import java.sql.Date;

import com.jam.repository.model.Story;

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
public class CreateStoryDTO {

	/*
	 * (#{bookId}, #{userId}, #{number}, #{type}, #{author}, #{title}, #{uploadDay},
	 * #{save}, #{cost}, #{content})
	 */

	private Integer number;
	private String type;
	private String author;
	private String title;
	private Date uploadDay;
	private String save;
	private Integer cost;
	private String contents;

	public Story toStroy(Integer bookId, Integer principalId) {
		return Story.builder()
				.bookId(bookId)
				.userId(principalId)
				.number(this.number)
				.type(this.type)
				.title(this.title)
				.uploadDay(this.uploadDay)
				.save(this.save)
				.cost(this.cost)
				.contents(this.contents)
				.build();
	}
}
