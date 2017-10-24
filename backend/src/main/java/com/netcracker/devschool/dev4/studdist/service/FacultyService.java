package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Faculty;

import java.util.List;

/**
 * Created by Shaleshka on 24.10.17.
 */
public interface FacultyService {
    public Faculty create(Faculty faculty);

    public Faculty delete(int id) throws Exception;

    public List<Faculty> findAll();

    public Faculty update(Faculty faculty) throws Exception;

    public Faculty findById(int id);
}
