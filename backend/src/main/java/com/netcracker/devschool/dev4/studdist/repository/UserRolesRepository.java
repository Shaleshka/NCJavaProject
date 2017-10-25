package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.UserRoles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRolesRepository extends JpaRepository<UserRoles, Integer> {

    @Query("select b from UserRoles b where b.username = :username")
    UserRoles findByUsername(@Param("username") String name);

}