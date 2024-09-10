package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jam.repository.interfaces.FundingRepository;
import com.jam.repository.interfaces.ProjectRepository;
import com.jam.repository.interfaces.RewardRepository;
import com.jam.repository.model.Project;
import com.jam.repository.model.Reward;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FundingService {

	
	private final FundingRepository fundingRepository;
	private final ProjectRepository projectRepository;
	private final RewardRepository rewardRepository;

	public List<Project> findAllProject() {
		List<Project> projects = new ArrayList<>();

		projects = projectRepository.findAllProject();

		return projects;
	}
	
	public void insertProject(Project project, Reward reward) {
		projectRepository.insertProject(project);
		Project projectId = projectRepository.findProjectByBookId(project.getBookId());
		rewardRepository.insertRewardByProjectId(projectId.getProjectId(), reward);
	}
}
