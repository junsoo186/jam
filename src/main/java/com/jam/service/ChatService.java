package com.jam.service;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class ChatService {
	
	// 방 목록을 저장하는 ConcurrentHashMap (동시성 보장)
    private final Set<String> roomIds = ConcurrentHashMap.newKeySet();

    // 초기화 시 기본 방 몇 개를 추가
    public ChatService() {
//        roomIds.add("1");
//        roomIds.add("2");
//        roomIds.add("3");
//        roomIds.add("37");
    }

    // 방 목록을 반환하는 메서드
    public Set<String> getChatRoomList() {
        return roomIds;
    }

    // 새로운 방을 생성하는 메서드
    public String createNewRoom(String roomId) {
        // 새로운 방 ID를 생성 (간단하게 현재 방의 크기 + 1로 생성)
    	 roomIds.add(roomId);  // 새로운 방 ID를 목록에 추가
        return roomId;
    }

    // 방이 존재하는지 확인하는 메서드
    public boolean isRoomExist(String roomId) {
        return roomIds.contains(roomId);
    }

}

