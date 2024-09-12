//package com.jam.repository.interfaces;
//
//import java.sql.Date;
//import java.util.List;
//
//import org.apache.ibatis.annotations.Mapper;
//
//import com.jam.dto.EventDTO;
//import com.jam.repository.model.Event;
//
//import io.lettuce.core.dynamic.annotation.Param;
//
//@Mapper
//public interface EventRepository {
//
//	/**
//	 * event 관리자 페이지 
//	 * 1. 이벤트 등록
//	 * 2. 삭제 
//	 * 3. 수정
//	 */
//	
//	public int insertE(Event event); // 글쓰기
//	public int updateE(@Param("eventId")int eventId, @Param("eventTitle")String eventTitle,@Param("eventContent") String eventContent, @Param("startDay")Date startDay,@Param("endDay")Date endDay); // 글수정
//	public int deleteE(int eventId); // 글삭제
//	public List<Event> selectAllPage(@Param("limit") int limit, @Param("offset") int offset);
//	public Event selectByEventId(int eventId); // 상세보기
//	public int countAll();
//	
//	
//}

package com.jam.repository.interfaces;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Event;

@Mapper
public interface StaffEventRepository {

    public int insertE(Event event); // 글쓰기
    public int updateE(@Param("eventId") int eventId, @Param("eventTitle") String eventTitle, 
                       @Param("eventContent") String eventContent, @Param("startDay") Date startDay, 
                       @Param("endDay") Date endDay); // 글수정
    public int deleteE(int eventId); // 글삭제
    public List<Event> selectAllPage(@Param("limit") int limit, @Param("offset") int offset); // 페이지 조회
    public Event selectByEventId(int eventId); // 상세보기
    public int countAll(); // 전체 개수
}
