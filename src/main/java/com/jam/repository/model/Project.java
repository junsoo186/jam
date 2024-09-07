package com.jam.repository.model;

import java.sql.Date;
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
public class Project {

    private int projectId;
    private int userId; 
    private int rewardId; 
    private int bookId; 
    private String title;
    private String contents;
    private int goal;
    private Date dateEnd;
    private Timestamp createdAt;
    private String staffAgree; // Enum ('N', 'Y')
}
