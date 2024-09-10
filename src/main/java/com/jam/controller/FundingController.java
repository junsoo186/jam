package com.jam.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jam.dto.ProjectDTO;
import com.jam.dto.RewardDTO;
import com.jam.repository.model.Book;
import com.jam.repository.model.Project;
import com.jam.repository.model.Reward;
import com.jam.repository.model.User;
import com.jam.service.FundingService;
import com.jam.service.WriterService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/funding")
@RequiredArgsConstructor
public class FundingController {

	private final HttpSession session;
	private final FundingService fundingService;
	private final WriterService writerService;

	@GetMapping("/createFunding")
	public String handleFundingPage(@RequestParam("bookId") Integer bookId,
			Model model) {
		User principal = (User) session.getAttribute("principal");
		Book book = writerService.findBookByBookId(bookId);

		model.addAttribute("book", book);
		model.addAttribute("principal", principal);
		return "funding/createFunding";
	}

	@PostMapping("/createFunding")
	public String createFunding(ProjectDTO projectDTO, @RequestParam("bookId") Integer bookId, RewardDTO rewardDTO) {
		User principal = (User) session.getAttribute("principal");
		Project project = projectDTO.toProject(principal.getUserId(), bookId, principal.getNickName());
		Reward reward = rewardDTO.toReward(project.getProjectId());

		// 서비스 또는 리포지토리 호출하여 프로젝트 저장
		fundingService.insertProject(project,reward);

		// 펀딩 목록 페이지로 리다이렉트
		return "redirect:funding/fundingList"; // TODO - funding detail로 이동
	}

	@GetMapping("/fundingList")
	public String handleFundingList(Model model) {
		List<Project> projects = fundingService.findAllProject();
		model.addAttribute("projectList", projects);

		return "funding/fundingList";
	}

}
