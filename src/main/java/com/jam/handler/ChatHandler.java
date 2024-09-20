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


    // 방별로 세션과 대화 기록을 저장할 Map
    private final ConcurrentHashMap<String, Set<WebSocketSession>> roomSessions = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, List<String>> chatHistory = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String roomId = getRoomIdFromSession(session);
        
        // 방이 없으면 초기화
        roomSessions.putIfAbsent(roomId, ConcurrentHashMap.newKeySet());
        chatHistory.putIfAbsent(roomId, new CopyOnWriteArrayList<>());

        roomSessions.get(roomId).add(session);

        // 새로운 사용자에게 기존 대화 기록 전송
        List<String> roomHistory = chatHistory.get(roomId);
        for (String message : roomHistory) {
            session.sendMessage(new TextMessage(message));
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String roomId = getRoomIdFromSession(session);
        String payload = message.getPayload();

        // 새로운 메시지를 대화 기록에 추가
        chatHistory.get(roomId).add(payload);

        // 모든 사용자에게 메시지 전송
        for (WebSocketSession webSocketSession : roomSessions.get(roomId)) {
            if (webSocketSession.isOpen()) {
                webSocketSession.sendMessage(new TextMessage(payload));
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String roomId = getRoomIdFromSession(session);
        roomSessions.get(roomId).remove(session);
    }

    // URL에서 roomId를 추출하는 메서드
    private String getRoomIdFromSession(WebSocketSession session) {
        return session.getUri().getPath().split("/ws/chat/")[1]; // WebSocket 경로에서 roomId 추출
    }
}