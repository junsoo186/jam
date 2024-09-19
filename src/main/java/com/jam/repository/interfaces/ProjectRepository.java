package com.jam.repository.interfaces;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.dto.ProjectDTO;
import com.jam.repository.model.Content;
import com.jam.repository.model.Project;

@Mapper
public interface ProjectRepository {

	void insertProject(Project project); // 프로젝트 생성

	public void insertProjectImg(@Param("projectId") Integer projectId,
			@Param("projectImg") String projectImg); // 프로젝트 이미지 생성

	public List<Project> findAllProject(@Param("size") int size, @Param("offset") int offset); // 프로젝트 리스트 출력

	public Project findDetailProject(@Param("projectId") Integer projectId); // 프로젝트 자세히

	// 프로잭트 업데이트
	public void updateProject(ProjectDTO projectDTO);

	public void updateProjectImg(String projectImg);

	// 승인
	public int projectAgree(@Param("staffAgree") String staffAgree, @Param("projectId") Integer projectId);

	public void deleteProject(@Param("projectId") Integer projectId);

	public Project findProjectByBookId(Integer bookId);

	public List<Content> findAllProjectImgByProjectId(Integer projectId);

	public Project findProjectByProjectId(Integer projectId);

	public Content findImageByContentId(Integer contentId); // 이미지 삭제 대상을 찾기

	public void deleteProjectImage(Integer contentId); // 이미지 삭제

	public List<Project> findByDeadlineBeforeAndIsCanceledFalse(@Param("now") LocalDateTime now);

    int getTotalProjectCount();

}
