package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jam.repository.interfaces.NoticeRepository;
import com.jam.repository.model.Notice;
import com.jam.service.NoticeService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notice")
public class NoticeController {

    private final NoticeService noticeService;

    @Autowired
    private NoticeRepository noticeRepository;

    /**
     * 게시글 목록 페이지 요청
     */
    @GetMapping({ "/list", "/" })
    public String listPage(Model model) {
        List<Notice> noticeList = noticeService.findAll();
        model.addAttribute("noticeList", noticeList);
        return "notice/list";
    }
    

    /**
     * 게시글 저장, 등록 화면단
     */
    @GetMapping("/insertForm")
    public String insertForm() {
        return "notice/insertForm"; 
    }

    /**
     * 게시글 저장, 등록
     */
    @PostMapping("/insert")
    public String insert(@RequestParam(name = "notice_id", required = false, defaultValue = "0") int noticeId,
                         @RequestParam(name = "staff_id", required = false, defaultValue = "0") int staffId, // 매개변수 이름 수정
                         @RequestParam(name = "title", required = false, defaultValue = "") String noticeTitle,
                         @RequestParam(name = "content", required = false, defaultValue = "") String noticeContent,
                         @RequestParam(name = "comment", required = false, defaultValue = "") String comment) {
        Notice notice = Notice.builder()
                              .noticeId(noticeId)
                              .staffId(staffId)
                              .noticeTitle(noticeTitle)
                              .noticeContent(noticeContent)
                              .comment(comment)
                              .build();

        noticeRepository.insert(notice);

        return "redirect:/notice/list";
    }


    
    
    @PostMapping("/delete")
    public String delete(@RequestParam("noticeId") int noticeId,
                         @RequestParam(value = "action", required = false) String action,
                         Model model) {
    	System.out.println("@@@@@@@@@@@@");
        if ("delete".equals(action)) {
            // 삭제 요청 시 게시글 ID를 모델에 추가하고 목록 페이지로 이동
            model.addAttribute("noticeId", noticeId);
            return "notice/list"; 
        } else if ("confirm".equals(action)) {
            // 비밀번호 확인 없이 바로 삭제 처리
            noticeService.deleteById(noticeId);
            model.addAttribute("successMessage", "게시글이 삭제되었습니다.");
            return "redirect:/notice/list"; 
        }
        return "redirect:/notice/list";
    }



	
}
    
    
    /**
     * 게시글 수정
     */
    
    
    // 수정 기능을 위한 메서드 추가 필요

