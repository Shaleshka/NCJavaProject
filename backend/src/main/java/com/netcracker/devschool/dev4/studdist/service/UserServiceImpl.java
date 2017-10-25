package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.User;
import com.netcracker.devschool.dev4.studdist.entity.UserRoles;
import com.netcracker.devschool.dev4.studdist.repository.UserRepository;
import com.netcracker.devschool.dev4.studdist.repository.UserRolesRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Shaleshka on 19.10.17.
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserRepository userRepository;

    @Resource
    private UserRolesRepository userRolesRepository;


    @Override
    @Transactional
    public UserRoles create(User user, UserRoles userRoles) {

        userRepository.save(user);
        return userRolesRepository.save(userRoles);
    }

    @Override
    @Transactional
    public User delete(long id) throws Exception {
        User deletedUser = userRepository.findOne((int) id);

        if (deletedUser == null)
            throw new Exception("Not found");

        userRepository.delete(deletedUser);
        return deletedUser;
    }

    @Override
    @Transactional
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    @Transactional
    public User update(User user) throws Exception {
        return null;
    }

    @Override
    @Transactional
    public User findById(long id) {
        return userRepository.findOne((int) id);
    }

    @Override
    public int getIdByName(String name) {
        return userRolesRepository.findByName(name).getUser_role_id();
    }
}
