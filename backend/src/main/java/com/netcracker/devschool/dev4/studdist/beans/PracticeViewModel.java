package com.netcracker.devschool.dev4.studdist.beans;

import java.util.Date;

public class PracticeViewModel {
    private int id;
    private int hopId;
    private String name;
    private String faculty;
    private String speciality;
    private double minAvg;
    private int number;
    private Date start;
    private Date end;
    private int isBudget;

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

    public String getFaculty() {
        return faculty;
    }

    public void setFaculty(String faculty) {
        this.faculty = faculty;
    }

    public String getSpeciality() {
        return speciality;
    }

    public void setSpeciality(String speciality) {
        this.speciality = speciality;
    }

    public double getMinAvg() {
        return minAvg;
    }

    public void setMinAvg(double minAvg) {
        this.minAvg = minAvg;
    }

    public int getIsBudget() {
        return isBudget;
    }

    public void setIsBudget(int isBudget) {
        this.isBudget = isBudget;
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

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
}
