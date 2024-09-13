package com.jam.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ChartDataController {

	@GetMapping("/chart-data")
	public Map<String, Object> getChartData() {
		Map<String, Object> data = new HashMap<>();
		data.put("labels", new String[] { "Red", "Blue", "Yellow", "Green", "Purple", "Orange" });
		data.put("data", new int[] { 12, 19, 3, 5, 2, 3 });
		return data; // JSON 형식으로 반환됨
	}
}