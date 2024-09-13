package com.jam.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.jam.dto.ProjectDTO;
import com.jam.dto.RewardDTO;
import com.jam.repository.interfaces.FundingRepository;
import com.jam.repository.interfaces.ProjectRepository;
import com.jam.repository.interfaces.RewardRepository;
import com.jam.repository.interfaces.UserRepository;
import com.jam.repository.model.Content;
import com.jam.repository.model.Funding;
import com.jam.repository.model.Project;
import com.jam.repository.model.Reward;
import com.jam.utils.Define;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FundingService {

	private final FundingRepository fundingRepository;
	private final ProjectRepository projectRepository;
	private final RewardRepository rewardRepository;
	private final UserRepository userRepository;


	@Value("${file.upload-dir}")
	private String uploadDir;

	public List<Project> findAllProject() {
		List<Project> projects = new ArrayList<>();

		projects = projectRepository.findAllProject();

		return projects;
	}

	@Transactional
	public void insertProject(Project project, List<RewardDTO> rewards, List<MultipartFile> projectImgs) {
		if (projectImgs != null && !projectImgs.isEmpty()) {
			// 첫 번째 이미지를 메인 이미지로 설정
			MultipartFile mainImgFile = projectImgs.get(0);

			if (!mainImgFile.isEmpty()) {
				String[] mainFileNames = uploadFile(mainImgFile); // 메인 이미지 업로드
				project.setOriginalMainImg(mainFileNames[0]);
				project.setMainImg(mainFileNames[1]);
			} else {
				// 메인 이미지가 없을 경우 처리 (예: 기본 이미지 설정 또는 예외 발생)
				throw new IllegalArgumentException("메인 이미지를 선택해야 합니다.");
			}

			// 프로젝트 정보 삽입
			projectRepository.insertProject(project);
			Integer projectId = project.getProjectId();

			// 나머지 이미지들을 프로젝트 이미지로 삽입
			for (int i = 1; i < projectImgs.size(); i++) {
				MultipartFile img = projectImgs.get(i);
				if (!img.isEmpty()) {
					String[] fileNames = uploadFile(img);
					project.setOriginalProjectImg(fileNames[0]);
					project.setProjectImg(fileNames[1]);

					projectRepository.insertProjectImg(projectId, project.getProjectImg());
				}
			}

			// 리워드가 있는 경우에만 저장
			if (rewards != null && !rewards.isEmpty()) {
				for (RewardDTO reward : rewards) {
					reward.setProjectId(projectId); // 각 리워드에 projectId 설정
					rewardRepository.insertRewardByProjectId(reward);
				}
			} else {
				// 리워드가 없을 경우 처리 (필요에 따라 예외 처리 또는 로그)
				System.out.println("리워드가 없습니다.");
			}
		} else {
			throw new IllegalArgumentException("프로젝트 이미지를 최소 1개는 선택해야 합니다.");
		}
	}

	/**
	 * 서버 운영체제에 파일 업로드 기능 MultipartFile getOriginalFilename : 사용자가 작성한 파일 명
	 * uploadFileName : 서버 컴퓨터에 저장 될 파일 명
	 * 
	 * @param mFile
	 * @return
	 */
	@Transactional
	private String[] uploadFile(MultipartFile mFile) {
		if (mFile.getSize() > Define.MAX_FILE_SIZE) {
			// TODO - 오류 처리
			// throw new DataDeliveryException("파일 크기는 20MB 이상 클 수 없습니다.",
			// HttpStatus.BAD_REQUEST);
		}

		// 코드 수정
		// File - getAbsolutePath()
		// (리눅스 또는 MacOS)에 맞춰서 절대 경로 생성을 시킬 수 있다.
		String saveDirectory = new File(uploadDir).getAbsolutePath();

		// 파일 이름 생성(중복 이름 예방)
		String uploadFileName = UUID.randomUUID() + "_" + mFile.getOriginalFilename();
		// 파일 전체 경로 + 새로생성한 파일명
		String uploadPath = saveDirectory + File.separator + uploadFileName;
		File destination = new File(uploadPath);

		// 반드시 수행
		try {
			mFile.transferTo(destination);
		} catch (IllegalStateException | IOException e) {
			// TODO - 오류 처리
			// e.printStackTrace();
			// throw new DataDeliveryException("파일 업로드 중 오류가 발생했습니다.",
			// HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new String[] { mFile.getOriginalFilename(), uploadFileName };
	}

	public Project findDetailProject(Integer projectId) {
		Project project = projectRepository.findDetailProject(projectId);

		return project;
	}

	public List<Reward> findRewardByProjectId(Integer projectId) {
		List<Reward> rewards = rewardRepository.findRewardByProjectId(projectId);

		return rewards;
	}

	public List<Content> findAllProjectImgByProjectId(Integer projectId) {
		List<Content> projectImgs = projectRepository.findAllProjectImgByProjectId(projectId);

		return projectImgs;
	}

	public Project findProjectByBookId(Integer bookId) {
		Project project = projectRepository.findProjectByBookId(bookId);

		return project;
	}

	public Project findProjectByProjectId(Integer projectId) {
		Project project = projectRepository.findProjectByProjectId(projectId);
		return project;
	}

	@Transactional
	public void updateProject(ProjectDTO projectDTO, Integer projectId, List<MultipartFile> mFiles) {
		// mFiles가 비어있지 않으면 첫 번째 이미지를 메인 이미지로 설정
		if (mFiles != null && !mFiles.isEmpty()) {
			// 첫 번째 이미지를 메인 이미지로 업로드
			MultipartFile mainImgFile = mFiles.get(0);
			if (!mainImgFile.isEmpty()) {
				String[] mainFileNames = uploadFile(mainImgFile);
				projectDTO.setOriginalMainImg(mainFileNames[0]); // 원본 이미지 파일명 설정
				projectDTO.setMainImg(mainFileNames[1]); // 업로드된 이미지 파일명 설정
			}
		}

		// 프로젝트 ID 설정
		projectDTO.setProjectId(projectId);

		// 프로젝트 정보 업데이트
		projectRepository.updateProject(projectDTO);

		// 나머지 이미지들을 프로젝트 이미지로 삽입
		if (mFiles != null && mFiles.size() > 1) {
			for (int i = 1; i < mFiles.size(); i++) {
				MultipartFile imgFile = mFiles.get(i);
				if (!imgFile.isEmpty()) {
					String[] projectImgFileNames = uploadFile(imgFile);
					projectDTO.setOriginalProjectImg(projectImgFileNames[0]); // 원본 이미지 파일명 설정
					projectDTO.setProjectImg(projectImgFileNames[1]); // 업로드된 이미지 파일명 설정

					// 프로젝트 이미지 삽입
					projectRepository.insertProjectImg(projectId, projectDTO.getProjectImg());
				}
			}
		}
	}

	@Transactional
	public void updateReward(List<RewardDTO> rewards, Integer projectId) {
		// DB에서 해당 프로젝트의 모든 리워드 조회
		List<RewardDTO> existingRewards = rewardRepository.findRewardDTOByProjectId(projectId);

		// 업데이트 또는 추가할 리워드 목록 처리
		// 2. 요청된 리워드 순회 (업데이트 또는 추가 처리)
		for (RewardDTO reward : rewards) {
			if (reward.getRewardId() != null) {
				// 2-1. rewardId가 있으면 업데이트
				rewardRepository.updateRewardByProjectId(reward);
			} else {
				// 2-2. rewardId가 없으면 새로 추가
				reward.setProjectId(projectId);
				rewardRepository.insertRewardByProjectId(reward);
			}
		}

		// 3. 요청에 없는 기존 리워드는 삭제 처리
		for (RewardDTO existingReward : existingRewards) {
			boolean isRewardStillExists = rewards.stream()
					.anyMatch(reward -> Objects.equals(reward.getRewardId(), existingReward.getRewardId())); // null-safe
																												// equals

			if (!isRewardStillExists) {
				fundingRepository.deleteByRewardId(existingReward.getRewardId());
				rewardRepository.deleteReward(existingReward.getRewardId());
			}
		}
	}

	@Transactional
	public void deleteProjectImage(Integer contentId) {
		// 데이터베이스에서 이미지 정보 조회
		Content projectImage = projectRepository.findImageByContentId(contentId);

		System.out.println("이미지 찾음 : " + projectImage);
		if (projectImage != null) {
			// 파일 시스템에서 이미지 삭제
			File file = new File(uploadDir + projectImage.getImg());
			if (file.exists()) {
				file.delete(); // 실제 이미지 파일 삭제
			}

			// 데이터베이스에서 이미지 정보 삭제
			projectRepository.deleteProjectImage(contentId);
		}
	}

    public boolean insertRewardByUserId(Integer userId, Integer rewardId) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'insertRewardByUserId'");
    }

    public void insertFunding(Funding funding) {
		fundingRepository.insertFunding(funding);
    }

    public Reward findRewardByRewardId(Integer rewardId) {
        Reward reward = rewardRepository.findRewardByRewardId(rewardId);
        return reward;
    }

	public List<Funding> findFundingByUserId(int userId) {
		List<Funding> fundings = fundingRepository.findFundingByUserId(userId);
		return fundings;
	}

}
