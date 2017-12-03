package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.HeadOfPractice;
import org.springframework.data.domain.Page;

import java.util.List;

public interface HeadOfPracticeService {

    HeadOfPractice create(HeadOfPractice headOfPractice);

    HeadOfPractice delete(int id) throws Exception;

    List<HeadOfPractice> findAll();

    HeadOfPractice update(HeadOfPractice headOfPractice) throws Exception;

    HeadOfPractice findById(int id);

    Page<HeadOfPractice> findForPractice(String searchKey, String sortBy, String order, int start, int length);

}
