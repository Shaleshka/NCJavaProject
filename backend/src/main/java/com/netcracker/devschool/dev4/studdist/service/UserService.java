package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.User;
import com.netcracker.devschool.dev4.studdist.entity.UserRoles;

import java.util.List;

public interface UserService {
    UserRoles create(User user, UserRoles userRoles);

    User delete(long id) throws Exception;

    List<User> findAll();

    User update(User user) throws Exception;

    User findById(long id);

    int getIdByName(String name);
}
