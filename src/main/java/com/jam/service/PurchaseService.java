package com.jam.service;

import org.springframework.stereotype.Service;

import com.jam.dto.PurchaseDTO;
import com.jam.repository.interfaces.PurchaseRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PurchaseService {
    private final PurchaseRepository purchaseRepository;

    public String checkPurchaseStatus(int userId, int bookId, int storyId) {
        return purchaseRepository.isPurchaseExists(userId, bookId, storyId);
    }

    // 구매 기록 삽입
    public void insertPurchase(PurchaseDTO purchaseDTO) {
        purchaseRepository.insertPurchase(purchaseDTO);
    }
}
