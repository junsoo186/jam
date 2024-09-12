package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Event;
@Mapper
public interface EventRepository {
	public List<Event> selectAllPage(@Param("limit") int limit, @Param("offset") int offset); // 페이지 조회
    public Event selectByEventId(int eventId); // 상세보기
    public int countAll(); // 전체 개수
}
