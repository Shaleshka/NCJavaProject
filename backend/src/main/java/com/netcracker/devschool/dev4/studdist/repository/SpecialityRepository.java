package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.Speciality;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SpecialityRepository extends JpaRepository<Speciality, Integer> {

    @Query("select s from Speciality s where s.facultyId = :facultyid")
    List<Speciality> findByFacultyId(@Param("facultyid") int facultyId);

    @Query("delete from Speciality s where s.facultyId = :facultyId")
    @Modifying
    void deleteByFacultyId(@Param("facultyId") int facultyId);

}
