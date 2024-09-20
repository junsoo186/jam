package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.jam.repository.interfaces.MainBannerRepository;
import com.jam.repository.model.MainBanner;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainBannerService {

	private final MainBannerRepository mainBannerRepository;

	
	/**
	 *  메인배너 id 사용
	 * @param id
	 * @return
	 */
	public MainBanner readMainBannerById(int id) {
	 MainBanner	MainBanner =mainBannerRepository.selectById(id);
	 return MainBanner;
	}
	
	/**
	 * 메인배너 eventId 사용
	 * @param id
	 * @return
	 */
	public MainBanner findMainBannerByEventId(int id) {
		 MainBanner	MainBanner =mainBannerRepository.selectByEventId(id);
		 return MainBanner;
		}
	
	public List<MainBanner> readAllMainBanner(int page,int size) {
		List<MainBanner> mainBannerList=new ArrayList<>();
		int limit = size;
		int offset = (page - 1) * size;
		mainBannerList= mainBannerRepository.selectAllMainBanner(limit,offset);
		return mainBannerList;
		
	}
	
	public int countAllBanner() {
		int sumCount=mainBannerRepository.countAllMainBanner();
		return sumCount;
	}
}
