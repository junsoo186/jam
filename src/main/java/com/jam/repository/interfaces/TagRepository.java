package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.Tag;
@Mapper
public interface TagRepository {
    public int insertTag(String tagName);
    public Tag selectTagById(int tagId);
    public List<Tag> selectAllTags();
}
