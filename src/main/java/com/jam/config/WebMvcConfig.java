package com.jam.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import java.util.List;
import java.util.ArrayList;
import com.jam.handler.AuthInterceptor;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class WebMvcConfig implements WebMvcConfigurer {

	private final AuthInterceptor authInterceptor;
	
	// @Override
	// public void addInterceptors(InterceptorRegistry registry) {
	// 	List<String> excludeList = new ArrayList<>();
	// 	excludeList.add("/write/workDetail");
	// 	excludeList.add("/user/sign-in");
	// 	excludeList.add("/css/**");
	// 	excludeList.add("/images/**");
	// 	excludeList.add("/");	
	// 	excludeList.add("/js/**");
	// 	registry.addInterceptor(authInterceptor).addPathPatterns("/**").excludePathPatterns(excludeList);
	// }
	

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/images/uploads/**").addResourceLocations("src/main/resources/static/");
	}

	@Bean // IoC 대상(싱글톤 처리)
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
