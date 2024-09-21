package com.jam.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.jam.handler.ChatHandler;
@Configuration // Spring의 설정 파일임을 나타냄
@EnableWebSocket // WebSocket 기능을 활성화하는 어노테이션
public class WebSocketConfig implements WebSocketConfigurer {
	/**
	 WebSocket 핸들러를 등록하는 메서드
     * @param registry WebSocket 핸들러를 등록하기 위한 레지스트리
	 */
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    	// WebSocket 핸들러를 등록함
        // ChatHandler는 실제로 메시지를 처리하는 핸들러이며, "/ws/chat/{roomId}" 경로에서 WebSocket 연결을 처리함
    	 registry.addHandler(new ChatHandler(), "/ws/chat/{roomId}")
    	 .setAllowedOrigins("*"); // CORS 설정: 모든 도메인에서 접속 가능하게 함
    }
}
