package com.jam.controller;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
@Controller
public class likes {
    
//     @PostMapping("/like")
// public ResponseEntity<String> toggleLike(@RequestBody Map<String, Integer> payload) {
//     Integer bookId = payload.get("bookId");
    
//     // 좋아요 처리 로직
//     boolean success = likeService.toggleLike(bookId);

//     if (success) {
//         return ResponseEntity.ok("Like toggled successfully");
//     } else {
//         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to toggle like");
//     }
// }
}
