package com.jam.repository.model;

import java.util.List;

import com.jam.dto.GenreDTO;

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

public class Genre {

	private Integer genreId;
	private String genreName;
	
	public GenreDTO toGenreDTO() {
		return GenreDTO.builder()
						.genreId(genreId)
						.genreName(genreName)
						.build();

	}
}
