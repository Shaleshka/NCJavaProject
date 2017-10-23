package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.HeadOfPractice;
import com.netcracker.devschool.dev4.studdist.repository.HeadOfPracticeRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Shaleshka on 23.10.17.
 */
@Service
public class HeadOfPracticeServiceImpl implements HeadOfPracticeService {

    @Resource
    private HeadOfPracticeRepository headOfPracticeRepository;


    @Override
    public HeadOfPractice create(HeadOfPractice headOfPractice) {
        return headOfPracticeRepository.save(headOfPractice);
    }

    @Override
    public HeadOfPractice delete(int id) throws Exception {
        HeadOfPractice deleted = headOfPracticeRepository.findOne(id);
        if (deleted == null) throw new Exception("Not found");
        headOfPracticeRepository.delete(id);
        return deleted;
    }

    @Override
    public List<HeadOfPractice> findAll() {
        return headOfPracticeRepository.findAll();
    }

    @Override
    public HeadOfPractice update(HeadOfPractice headOfPractice) throws Exception {
        return null; //TODO
    }

    @Override
    public HeadOfPractice findById(int id) {
        return headOfPracticeRepository.findOne(id);
    }
}
