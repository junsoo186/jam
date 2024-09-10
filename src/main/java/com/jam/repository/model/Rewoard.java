package com.jam.repository.model;

import com.google.auto.value.AutoValue.Builder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Rewoard {

    private int rewardId;
    private int projectId;
    private String rewardContent;
    private long rewardPoint;
}
