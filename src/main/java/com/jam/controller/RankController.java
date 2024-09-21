package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jam.repository.model.Book;
import com.jam.service.WriterService;

@Controller
@RequestMapping("/rank")
public class RankController {

	private final WriterService writeService;

	@Autowired
	public RankController(WriterService writeService) {
		this.writeService = writeService;
	}

	@GetMapping("/ranking")
    public String getBookRanking(@RequestParam(name = "sort",defaultValue = "views") String sort, Model model) {
        List<Book> books = writeService.getBooksSortedBy(sort);
        for (Book book : books) {
        	book.setBookCoverImage(book.setUpUserImage());
		}
        model.addAttribute("ranks", books);
        return "bookRanking";  // bookRanking.jsp 페이지로 이동
    }
}
