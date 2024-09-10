package com.jam.dto;

import com.jam.repository.model.Genre;

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
public class GenreDTO {

	private Integer genreId;
	private String genreName;
}
