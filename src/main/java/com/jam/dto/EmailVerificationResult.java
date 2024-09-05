package com.jam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmailVerificationResult {

    private boolean success;

    // 정적 팩토리 메서드로 결과 생성
    public static EmailVerificationResult of(boolean success) {
        return new EmailVerificationResult(success);
    }
}
