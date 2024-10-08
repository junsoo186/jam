package com.jam.repository.model;

import java.util.List;

import com.jam.dto.CategoryDTO;

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

public class Category {

	private Integer categoryId;
	private String categoryName;
	
	public CategoryDTO toCategoryDTO() {
		return CategoryDTO.builder()
				.categoryId(categoryId)
				.categoryName(categoryName)
				.build();
	}
}
