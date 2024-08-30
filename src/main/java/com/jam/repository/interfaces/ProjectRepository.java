package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jam.repository.model.Project;

public interface ProjectRepository {

	public int insertProject(Project project); // 프로젝트 생성

	public List<Project> findAllProject(); // 프로젝트 리스트 출력

	public Project detailProject(@Param("projectId") Integer projectId); // 프로젝트 자세히

	// 프로잭트 업데이트
	public void updateProject(Project project);

	// 모금액 갱신
	public int updateProjectCollectedAmount(@Param("amount") Integer amount, @Param("projectId") Integer projectId);
	
	// 승인
	public int projectAgree(@Param("staffAgree") String staffAgree, @Param("projectId") Integer projectId);
	
	public void deleteProject(@Param("projectId") Integer projectId);
}
