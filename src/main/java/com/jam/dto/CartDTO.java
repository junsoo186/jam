package com.jam.dto;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class CartDTO {
    private int itemId;
    private String itemName;
    private int quantity;
    private int price;
    private int rewardId;
    private String rewardContent; // 추가된 필드
    private int rewardPoint;
}
