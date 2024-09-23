package com.jam.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jam.repository.interfaces.BookRepository;
import com.jam.repository.model.Book;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SearchService {
    
    private final BookRepository bookRepository;

    public List<Book> searchBooks (String searchTerm) {
        return bookRepository.searchBooks(searchTerm);
    }
}
