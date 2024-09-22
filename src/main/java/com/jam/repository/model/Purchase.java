package com.jam.repository.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder 
public class Purchase {

    private int purchaseId;
    private int userId;
    private int bookId;
    private int storyId;
    private Timestamp purchaseDate;
    
}
