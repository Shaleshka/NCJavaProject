package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.Assignment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AssignmentRepository extends JpaRepository<Assignment, Integer> {

    @Query("delete from Assignment a where a.practiceId = :id and a.studentId = :sid")
    @Modifying
    void remove(@Param("id") int id, @Param("sid") int sid);

}
