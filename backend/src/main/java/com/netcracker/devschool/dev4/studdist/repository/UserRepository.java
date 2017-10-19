package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Shaleshka on 19.10.17.
 */
public interface UserRepository extends JpaRepository<User, Integer> {

}
