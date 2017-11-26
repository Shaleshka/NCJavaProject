package com.netcracker.devschool.dev4.studdist.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "practices")
public class Practice {
    @Id
    @GeneratedValue
    private int id;
    private int hopId;
    private String name;
    private int facultyId;
    private int specialityId;
    private double minAvg;
    private Date start;
    private Date end;
    private int isBudget;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Practice practice = (Practice) o;

        return id == practice.id;
    }

    @Override
    public int hashCode() {
        return id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHopId() {
        return hopId;
    }

    public void setHopId(int hopId) {
        this.hopId = hopId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getFacultyId() {
        return facultyId;
    }

    public void setFacultyId(int facultyId) {
        this.facultyId = facultyId;
    }

    public int getSpecialityId() {
        return specialityId;
    }

    public void setSpecialityId(int specialityId) {
        this.specialityId = specialityId;
    }

    public double getMinAvg() {
        return minAvg;
    }

    public void setMinAvg(double minAvg) {
        this.minAvg = minAvg;
    }

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public int getIsBudget() {
        return isBudget;
    }

    public void setIsBudget(int isBudget) {
        this.isBudget = isBudget;
    }
}
