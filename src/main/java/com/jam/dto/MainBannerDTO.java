package com.jam.dto;

import java.util.List;

import com.jam.repository.model.MainBanner;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Data
@Builder
public class MainBannerDTO {

	List<MainBanner> mainBannerList;
	private int totalBanners; // 전체 배너 수

}
