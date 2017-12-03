package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.User;
import com.netcracker.devschool.dev4.studdist.entity.UserRoles;
import com.netcracker.devschool.dev4.studdist.repository.UserRepository;
import com.netcracker.devschool.dev4.studdist.repository.UserRolesRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

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
    public User delete(int id) throws Exception {
        User deletedUser = userRepository.findOne(id);

        if (deletedUser == null)
            throw new Exception("Not found");

        UserRoles userRoles = userRolesRepository.findByUsername(deletedUser.getUsername());

        userRepository.delete(deletedUser);
        userRolesRepository.delete(userRoles);
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
        User updated = userRepository.findOne(getIdByName(user.getUsername()));

        if (updated == null)
            throw new Exception("Not found");

        UserRoles userRoles = userRolesRepository.findByUsername(updated.getUsername());
        updated.setPassword(user.getPassword());
        updated.setUsername(user.getUsername());
        userRoles.setUsername(user.getUsername());
        return updated;
    }

    @Override
    @Transactional
    public User findById(int id) {
        return userRepository.findOne(id);
    }

    @Override
    @Transactional
    public int getIdByName(String name) {
        return userRolesRepository.findByUsername(name).getUser_role_id();
    }
}
