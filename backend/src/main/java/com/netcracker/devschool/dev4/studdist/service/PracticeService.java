package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Practice;

import java.util.List;

public interface PracticeService {
    Practice create(Practice practice);

    Practice findById(int id);

    Practice delete(int id) throws Exception;

    Practice update(Practice practice);

    List<Practice> findAll();

    List<Practice> findByHopId(int id);

    List<Practice> findByStudentId(int id);
}
