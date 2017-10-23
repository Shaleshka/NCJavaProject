package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Shaleshka on 23.10.17.
 */
public interface StudentRepository extends JpaRepository<Student, Integer> {
}
