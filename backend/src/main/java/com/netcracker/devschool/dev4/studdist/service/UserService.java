package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.User;
import com.netcracker.devschool.dev4.studdist.entity.UserRoles;

import java.util.List;

/**
 * Created by Shaleshka on 19.10.17.
 */
public interface UserService {
    public UserRoles create(User user, UserRoles userRoles);

    public User delete(long id) throws Exception;

    public List<User> findAll();

    public User update(User user) throws Exception;

    public User findById(long id);

    public int getIdByName(String name);
}
