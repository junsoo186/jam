package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Tag;

@Mapper
public interface TagRepository {
	public int insertTag(String tagName);

	public List<Tag> selectTagByBookId(Integer bookId);

	public List<Tag> selectAllTags();

	public int insertTagIdAndBookId(@Param("bookId") Integer bookId, @Param("tagId") Integer tagId);

	public Tag findByName(String tagName);

	public int updateTagIdByBookId(@Param("bookId") Integer bookId, @Param("tagId") Integer tagId);
}