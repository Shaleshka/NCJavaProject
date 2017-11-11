package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.Practice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PracticeRepository extends JpaRepository<Practice, Integer> {

    @Query("select l from Practice l where l.hopId = :hopId")
    List<Practice> findByHopId(@Param("hopId") int hopId);

    @Query("select l from Practice l where l.id in (select s from Assignment s where s.studentId = :id)")
    List<Practice> findByStudentId(@Param("id") int id);
}
