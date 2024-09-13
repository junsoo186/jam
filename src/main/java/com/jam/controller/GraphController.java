package com.jam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.jam.repository.interfaces.GraphRepository;

@Controller
public class GraphController {
	
	@Autowired
	private GraphRepository graphrepository;
	
	

}
