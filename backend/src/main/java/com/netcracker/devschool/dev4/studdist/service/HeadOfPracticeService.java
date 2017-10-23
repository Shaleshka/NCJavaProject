package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.HeadOfPractice;

import java.util.List;

/**
 * Created by Shaleshka on 23.10.17.
 */
public interface HeadOfPracticeService {

    public HeadOfPractice create(HeadOfPractice headOfPractice);

    public HeadOfPractice delete(int id) throws Exception;

    public List<HeadOfPractice> findAll();

    public HeadOfPractice update(HeadOfPractice headOfPractice) throws Exception;

    public HeadOfPractice findById(int id);

}
