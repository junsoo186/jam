package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.jam.dto.ProjectDTO;
import com.jam.repository.model.Content;
import com.jam.repository.model.Project;

@Mapper
public interface ProjectRepository {

	void insertProject(Project project); // 프로젝트 생성

	public void insertProjectImg(@Param("projectId") Integer projectId,
			@Param("projectImg") String projectImg); // 프로젝트 이미지 생성

	public List<Project> findAllProject(); // 프로젝트 리스트 출력

	public Project findDetailProject(@Param("projectId") Integer projectId); // 프로젝트 자세히

	// 프로잭트 업데이트
	public void updateProject(ProjectDTO projectDTO);

	public void updateProjectImg(String projectImg);

	// 승인
	public int projectAgree(@Param("staffAgree") String staffAgree, @Param("projectId") Integer projectId);

	public void deleteProject(@Param("projectId") Integer projectId);

	public Integer findProjectByBookId(Integer bookId);

	public List<Content> findAllProjectImgByProjectId(Integer projectId);

    public Project findProjectByProjectId(Integer projectId);
	
}
