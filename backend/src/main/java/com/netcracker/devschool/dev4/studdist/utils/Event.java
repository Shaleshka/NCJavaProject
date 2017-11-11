package com.netcracker.devschool.dev4.studdist.utils;

import java.util.Date;

//start or end of the practice - event for student
public class Event {
    private Date date;
    private int type; //0 - practice start, 1 - practice end
    private String companyName;
    private String hopName;
    private String practiceName;

    public Event(Date date, int type, String companyName, String hopName, String practiceName) {
        this.date = date;
        this.type = type;
        this.companyName = companyName;
        this.hopName = hopName;
        this.practiceName = practiceName;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getHopName() {
        return hopName;
    }

    public void setHopName(String hopName) {
        this.hopName = hopName;
    }

    public String getPracticeName() {
        return practiceName;
    }

    public void setPracticeName(String practiceName) {
        this.practiceName = practiceName;
    }
}
