package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.Category;
@Mapper
public interface CategoryRepository {
    public void insertCategory(Category category);
    public Category selectCategoryById(int categoryId);
    public List<Category> selectAllCategories();
}
