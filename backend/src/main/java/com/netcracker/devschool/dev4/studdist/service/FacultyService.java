package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Faculty;

import java.util.List;

public interface FacultyService {
    Faculty create(Faculty faculty);

    Faculty delete(int id) throws Exception;

    List<Faculty> findAll();

    Faculty update(Faculty faculty) throws Exception;

    Faculty findById(int id);
}
