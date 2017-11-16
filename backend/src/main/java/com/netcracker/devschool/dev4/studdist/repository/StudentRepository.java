package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StudentRepository extends JpaRepository<Student, Integer> {

    @Query("select l from Student l where l.id in (select p.studentId from Assignment " +
            "p where p.practiceId = :id) and concat(l.fname, l.lname, l.group, l.avgScore, " +
            "(select f.name from Faculty f where f.id = l.facultyId), (select s.name from " +
            "Speciality s where s.id = l.specialityId)) like concat('%', :skey, '%') ")
    Page<Student> findWithPracticeId(@Param("id") int id, @Param("skey") String key, Pageable page);

    @Query("select l from Student l where concat(l.fname, l.lname, l.group, l.avgScore, " +
            "(select f.name from Faculty f where f.id = l.facultyId), (select s.name from " +
            "Speciality s where s.id = l.specialityId)) like concat('%', :skey, '%') ")
    Page<Student> findWithoutPracticeId(@Param("skey") String key,  Pageable page);

    @Query("select l from Student l where l.facultyId = :fid and l.specialityId = :sid and l.avgScore >= :minavg")
    Page<Student> findForRequest(@Param("fid") int fid, @Param("sid") int sid, @Param("minavg") double minavg, Pageable page);

}
