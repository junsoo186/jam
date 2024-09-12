package com.jam.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jam.repository.interfaces.BennerRepository;
import com.jam.repository.model.Benner;

@Service
public class BennerService {
    @Autowired
    BennerRepository bennerRepository;


    public List<Benner> findAll(){
        List<Benner> bennerList = new ArrayList<>();
        bennerList = bennerRepository.selectAll();
        return bennerList;
    }
}
