package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.UserRoles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * Created by Shaleshka on 23.10.17.
 */
public interface UserRolesRepository extends JpaRepository<UserRoles, Integer> {

    @Query("select b from UserRoles b where b.username = :username")
    UserRoles findByName(@Param("username") String name);

}