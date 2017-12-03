package com.netcracker.devschool.dev4.studdist.repository;

import com.netcracker.devschool.dev4.studdist.entity.HeadOfPractice;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface HeadOfPracticeRepository extends JpaRepository<HeadOfPractice, Integer> {

    @Query("select l from HeadOfPractice l where concat(l.fname, l.lname, l.companyName)" +
            " like concat('%', :skey, '%') ")
    Page<HeadOfPractice> findForTable(@Param("skey") String key, Pageable page);

}
