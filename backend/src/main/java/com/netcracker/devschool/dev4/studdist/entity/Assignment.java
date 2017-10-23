package com.netcracker.devschool.dev4.studdist.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Shaleshka on 23.10.17.
 */
@Entity
@Table(name = "assignments")
public class Assignment {
    @Id
    private int practiceId;
    private int studentId;

    public int getPracticeId() {
        return practiceId;
    }

    public void setPracticeId(int practiceId) {
        this.practiceId = practiceId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Assignment that = (Assignment) o;

        if (practiceId != that.practiceId) return false;
        return studentId == that.studentId;
    }

    @Override
    public int hashCode() {
        int result = practiceId;
        result = 31 * result + studentId;
        return result;
    }
}
