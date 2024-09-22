package com.jam.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jam.dto.PurchaseDTO;

@Mapper
public interface PurchaseRepository {
    void insertPurchase(PurchaseDTO purchaseDTO);
    String isPurchaseExists(@Param("userId") Integer userId, 
    @Param("bookId") Integer bookId, 
    @Param("storyId") Integer storyId);
} 