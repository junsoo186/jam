package com.jam.handler;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler {

	// 현재 연결된 세션
	private final Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<>());

	// 채팅 메시지 저장소
	private final List<String> chatHistory = new CopyOnWriteArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		// 새로운 사용자에게 기존 채팅 기록 전송
		for (String message : chatHistory) {
			session.sendMessage(new TextMessage(message));
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 새로운 메시지를 저장소에 추가
		chatHistory.add(message.getPayload());

		// 모든 사용자에게 메시지 전송
		for (WebSocketSession webSocketSession : sessions) {
			if (webSocketSession.isOpen()) {
				webSocketSession.sendMessage(message);
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
	}
}