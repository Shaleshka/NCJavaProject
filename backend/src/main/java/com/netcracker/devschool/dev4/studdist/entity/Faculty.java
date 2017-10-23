package com.netcracker.devschool.dev4.studdist.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Shaleshka on 23.10.17.
 */
@Entity
@Table(name = "faculties")
public class Faculty {
    @Id
    private int id;
    private String name;
}
