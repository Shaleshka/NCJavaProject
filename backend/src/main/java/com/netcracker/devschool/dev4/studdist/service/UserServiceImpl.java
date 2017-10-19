package com.netcracker.devschool.dev4.studdist.service;

import java.util.List;

import javax.annotation.Resource;

import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.netcracker.devschool.dev4.studdist.entity.User;
import com.netcracker.devschool.dev4.studdist.repository.UserRepository;

/**
 * Created by Shaleshka on 19.10.17.
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserRepository userRepository;


    @Override
    @Transactional
    public User create(User user) {
        User createdUser = user;
        return userRepository.save(createdUser);
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
        User updatedUser = userRepository.findOne((int) user.getId());

        if (updatedUser == null)
            throw new Exception("Not found");

        updatedUser.setEmail(user.getEmail());
        updatedUser.setPassword(user.getPassword());
        updatedUser.setRole(user.getRole());
        return updatedUser;
    }

    @Override
    @Transactional
    public User findById(long id) {
        return userRepository.findOne((int) id);
    }
}
