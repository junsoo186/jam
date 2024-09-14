package com.jam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.jam.repository.interfaces.GraphRepository;
import com.jam.service.EventService;
import com.jam.vo.GraphVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/getGraphData")
public class GraphController {

	@Autowired
	GraphRepository graphRepository;

	@GetMapping
	@ResponseBody
	public String getGraphData() {
		// GraphRepository에서 데이터를 가져와서 List에 저장
		List<GraphVO> graphList = graphRepository.find();
		System.out.println("graphList 데이터: " + graphList);

		// Gson 객체를 사용해 List<GraphVO>를 JSON으로 변환
		Gson gson = new Gson();
		String json = gson.toJson(graphList);
		System.out.println("json 데이터 : " + json);

		return json; // 변환된 JSON 문자열을 반환
	}

}
