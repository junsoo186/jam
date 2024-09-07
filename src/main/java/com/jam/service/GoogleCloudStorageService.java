package com.jam.service;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

@Service
public class GoogleCloudStorageService {

    private final Storage storage = StorageOptions.getDefaultInstance().getService();
    private final String bucketName = "jamcache-gcs";  // Google Cloud Storage 버킷 이름

    // Google Cloud Storage에 파일 업로드
    public String uploadFile(MultipartFile file) throws IOException {
        String objectName = file.getOriginalFilename();  // 파일 이름을 객체 이름으로 사용

        BlobId blobId = BlobId.of(bucketName, objectName);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId).build();

        // 파일 업로드
        storage.create(blobInfo, file.getBytes());
        System.out.println("파일이 성공적으로 업로드되었습니다: " + objectName);
        
        return "https://storage.googleapis.com/" + bucketName + "/" + objectName;  // 파일 URL 반환
    }
}
