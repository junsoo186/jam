package com.jam.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class ImageUploadController {

	@PostMapping("/staff/image-upload")
	public ResponseEntity<?> uploadImage(@RequestParam("upload") MultipartFile file) {
		try {
			// 파일 저장 경로 설정
			String uploadDirectory = "/path/to/upload/directory";
			String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			Path filePath = Paths.get(uploadDirectory, fileName);

			// 파일 저장
			Files.write(filePath, file.getBytes());

			// 클라이언트에게 이미지 URL을 반환
			String imageUrl = "/images/" + fileName; // 이미지가 접근 가능한 URL
			return ResponseEntity.ok().body(Collections.singletonMap("url", imageUrl));
		} catch (IOException e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이미지 업로드에 실패했습니다.");
		}
	}

}
