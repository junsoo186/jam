package com.jam.handler;

import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler {


	// 각 채팅방별로 WebSocketSession(사용자 연결 세션)을 저장하는 Map
    // 방 ID (String) -> 해당 방의 WebSocketSession 목록 (Set)
    private final ConcurrentHashMap<String, Set<WebSocketSession>> roomSessions = new ConcurrentHashMap<>();
    
 	// 각 채팅방별로 대화 기록을 저장하는 Map
    // 방 ID (String) -> 해당 방의 대화 내용 (List)
    private final ConcurrentHashMap<String, List<String>> chatHistory = new ConcurrentHashMap<>();
    
    /**
     * 클라이언트(WebSocket)가 처음 연결되었을 때 호출되는 메서드
     * @param session WebSocket 연결 세션
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	// 현재 세션에서 채팅방 ID 추출
        String roomId = getRoomIdFromSession(session);
        
        // 방이 존재하지 않으면 새로 초기화
        roomSessions.putIfAbsent(roomId, ConcurrentHashMap.newKeySet()); // 새로운 채팅방 ID 추가
        chatHistory.putIfAbsent(roomId, new CopyOnWriteArrayList<>()); // 새로운 방의 대화 기록 초기화
        
        // 해당 방에 새로운 사용자의 WebSocketSession을 추가
        roomSessions.get(roomId).add(session);

        // 새로 접속한 사용자에게 기존 대화 기록 전송
        List<String> roomHistory = chatHistory.get(roomId);
        for (String message : roomHistory) {
        	// 이전 대화 내용을 새로운 사용자에게 전송
            session.sendMessage(new TextMessage(message));
        }
    }
    
    /**
     * 클라이언트로부터 텍스트 메시지를 수신했을 때 호출되는 메서드
     * @param session WebSocket 연결 세션
     * @param message 수신된 텍스트 메시지
     */
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	// 현재 세션에서 채팅방 ID 추출
    	String roomId = getRoomIdFromSession(session);
    	// 메시지의 실제 내용을 가져옴
        String payload = message.getPayload();

        // 대화 내용을 해당 채팅방의 대화 기록에 추가
        chatHistory.get(roomId).add(payload);

    	// 현재 채팅방에 연결된 모든 사용자에게 메시지를 전송
        for (WebSocketSession webSocketSession : roomSessions.get(roomId)) {
            if (webSocketSession.isOpen()) { // 세션이 열려 있는 경우에만 메시지 전송
                webSocketSession.sendMessage(new TextMessage(payload));
            }
        }
    }
    
    /**
     * 클라이언트(WebSocket)와 연결이 종료되었을 때 호출되는 메서드
     * @param session WebSocket 연결 세션
     * @param status 연결 종료 상태 정보
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	// 현재 세션에서 채팅방 ID 추출
    	String roomId = getRoomIdFromSession(session);
    	// 연결이 종료된 세션을 해당 채팅방에서 제거
        roomSessions.get(roomId).remove(session);
    }
    
    /**
     * WebSocket 세션에서 채팅방 ID(roomId)를 추출하는 유틸리티 메서드
     * @param session WebSocket 연결 세션
     * @return 추출된 채팅방 ID
     */
    private String getRoomIdFromSession(WebSocketSession session) {
    	// WebSocket URL에서 방 ID 추출 (예: "/ws/chat/{roomId}")
        return session.getUri().getPath().split("/ws/chat/")[1]; // WebSocket 경로에서 roomId 추출
    }
}