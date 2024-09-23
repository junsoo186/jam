package com.jam.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

import com.jam.handler.exception.RedirectException;


/**
 * 존재하지 않는 경로 요청시 예외 처리 (404) 
 */
@Controller // IoC (싱글톤 패턴 관리) 
public class CustomErrorController implements ErrorController {
	
	@GetMapping("/error")
	public void handleError(HttpServletRequest request) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		if(status != null) {
			Integer statusCode = Integer.valueOf(status.toString());
			
			if(statusCode == HttpStatus.NOT_FOUND.value()) {
				// 404 코드라면 
				throw new RedirectException("잘못된 요청입니다", HttpStatus.NOT_FOUND);
			}
			// 상세 설정 가능 함 
			// else if (statusCode == ....)
		}
	}
	
}


