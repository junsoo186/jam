package com.jam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.*;
import com.jam.repository.interfaces.BannerRepository;
import com.jam.repository.model.Banner;
import com.jam.utils.Define;

@Service
public class BannerService {

        @Autowired
    BannerRepository bannerRepository;

    @Value("${file.upload-dir}")
	private String uploadDir;


    public List<Banner> findAll(){

		
        List<Banner> bannerList = new ArrayList<>();

        bannerList = bannerRepository.selectAllBanner();
        return bannerList;

    }



    // private String[] uploadFile(MultipartFile mFile) {
	// 	// 파일 크기 제한 확인
	// 	if (mFile.getSize() > Define.MAX_FILE_SIZE) {
	// 		throw new RuntimeException("파일 크기는 20MB 이상일 수 없습니다.");
	// 	}
	
	// 	// 저장 디렉토리 확인 및 절대 경로로 변환
	// 	String saveDirectory = new File(uploadDir).getAbsolutePath();
	// 	System.out.println("저장 경로: " + saveDirectory);
	
	// 	// 파일 이름 생성 및 특수 문자 처리
	// 	String sanitizedFileName = mFile.getOriginalFilename().replaceAll("\\s+", "_");
	// 	String uploadFileName = "banner/" + UUID.randomUUID() + "_" + sanitizedFileName;
	// 	String uploadPath = saveDirectory + File.separator + uploadFileName;
	// 	File destination = new File(uploadPath);
	
	// 	// 파일 저장
	// 	try {
	// 		mFile.transferTo(destination);
	// 	} catch (IllegalStateException | IOException e) {
	// 		e.printStackTrace();
	// 		throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.", e);
	// 	}
	
	// 	return new String[]{mFile.getOriginalFilename(), uploadFileName};
	// }

}
