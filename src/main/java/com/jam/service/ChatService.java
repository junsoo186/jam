package com.jam.service;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class ChatService {
	
	// 방 목록을 저장하는 ConcurrentHashMap (동시성 보장)
	// 동시성 문제를 해결하기 위해 ConcurrentHashMap의 keySet을 사용하여 채팅방 ID들을 저장
    // 여러 스레드가 동시에 접근할 수 있으므로 동시성 처리가 가능한 자료구조 선택
    private final Set<String> roomIds = ConcurrentHashMap.newKeySet();

    // 기본 생성자: 초기화 시 기본적으로 몇 개의 방을 추가할 수 있음
    public ChatService() {
//        roomIds.add("1");
//        roomIds.add("2");
//        roomIds.add("3");
//        roomIds.add("37");
    }
    
    /**
     * 현재 존재하는 모든 채팅방 목록을 반환하는 메서드
     * @return 현재 존재하는 채팅방 ID 목록 (Set<String>)
     */
    public Set<String> getChatRoomList() {
        return roomIds; // 저장된 모든 채팅방 ID를 반환
    }
    
    /**
     * 새로운 채팅방을 생성하는 메서드
     * @param roomId 생성하려는 방의 ID
     * @return 생성된 방의 ID
     */
    public String createNewRoom(String roomId) {
    	// 새로운 방 ID를 roomIds Set에 추가
    	 roomIds.add(roomId);  
    	// 생성된 방 ID 반환
        return roomId;
    }

    /**
     * 특정 채팅방이 존재하는지 확인하는 메서드
     * @param roomId 확인하려는 방의 ID
     * @return 방이 존재하면 true, 없으면 false
     */
    public boolean isRoomExist(String roomId) {
    	// Set에 해당 방 ID가 존재하는지 확인
        return roomIds.contains(roomId); 
    }

}

