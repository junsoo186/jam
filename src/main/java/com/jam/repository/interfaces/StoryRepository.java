package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Story;

@Mapper
public interface StoryRepository {

	public int insertStory(Story story); // 회차 생성

	public List<Story> findAllStoryByBookId(@Param("bookId") Integer bookId); // 회차 목록 출력

	public Story outputStoryContentByStoryId(@Param("storyId") Integer storyId); // 소설
																				// 내용
																				// 출력
	public List<Story> readAllNumberByStoryId(@Param("storyId") Integer storyId);
	
	public Story findStoryNumberByBookId(@Param("bookId") Integer bookId);
	
	public int updateStory(Story story); // 회차 업데이트

	public void storyViewCountUp(@Param("storyId") Integer storyId); // 뷰어 카운트

	public void deleteStory(@Param("storyId") Integer storyId); // 회차 삭제
	
	public void updateNumberByStoryId(@Param("number") String number, @Param("storyId") Integer storyId); // 회차 넘버링만 변경
	
	public Story findStoryIdByBookIdAndUserId(@Param("bookId") Integer bookId, @Param("userId") Integer userId);
}
