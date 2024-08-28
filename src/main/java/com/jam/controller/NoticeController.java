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
     * 게시글 저장, 등록
     */
    @PostMapping("/save")
    public String saveNotice(@RequestParam("notice_id") int noticeId, @RequestParam("staff_id") int staffId,
                             @RequestParam("notice_title") String noticeTitle, @RequestParam("notice_content") String noticeContent,
                             @RequestParam("comment") String comment) {
        Notice notice = Notice.builder().noticeId(noticeId).staffId(staffId).noticeTitle(noticeTitle)
                              .noticeContent(noticeContent).comment(comment).build();

        noticeRepository.insert(notice);

        return "redirect:/notice/list";
    }

    /**
     * 게시글 삭제
     */
    @PostMapping("/delete")
    public String deleteNoticeByStaffId(@RequestParam("staffId") int staffId, RedirectAttributes redirectAttributes) {
        try {
            noticeRepository.delete(staffId);
            // 삭제 성공 메시지를 리디렉션 시 전달
            redirectAttributes.addFlashAttribute("message", "게시글이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            // 삭제 실패 메시지를 리디렉션 시 전달
            redirectAttributes.addFlashAttribute("errorMessage", "게시글 삭제에 실패했습니다: " + e.getMessage());
        }
        return "redirect:/notice/list"; // 삭제 후 목록 페이지로 리디렉션
    }

    /**
     * 게시글 수정
     */
    // 수정 기능을 위한 메서드 추가 필요
}
