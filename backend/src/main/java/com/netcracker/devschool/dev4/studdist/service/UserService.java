package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.User;

import java.util.List;

/**
 * Created by Shaleshka on 19.10.17.
 */
public interface UserService {
    public User create(User user);

    public User delete(long id) throws Exception;

    public List<User> findAll();

    public User update(User user) throws Exception;

    public User findById(long id);
}
