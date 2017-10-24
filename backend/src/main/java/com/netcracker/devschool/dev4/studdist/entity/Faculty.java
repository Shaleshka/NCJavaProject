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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Faculty faculty = (Faculty) o;

        return id == faculty.id;
    }

    @Override
    public int hashCode() {
        return id;
    }
}
