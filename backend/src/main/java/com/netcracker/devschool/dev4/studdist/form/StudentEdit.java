package com.netcracker.devschool.dev4.studdist.form;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class StudentEdit {

    /*@NotNull(message = "Электронная почта не может отсутствовать")
    @Size(min = 2, max = 45, message = "Электронная почта должна быть не короче двух и не длиннее 45 символов")
    private String email;

    @NotNull(message = "Пароль не может отсутствовать")
    @Size(min = 6, message = "Пароль должен быть длиннее 6 символов")
    private String password;*/

    @NotNull(message = "Имя не может отсутствовать")
    @Size(min = 2, max = 45, message = "Имя должно быть не короче двух и не длиннее 45 символов")
    private String fname;

    @NotNull(message = "Фамилия не может отсутствовать")
    @Size(min = 2, max = 45, message = "Фамилия должна быть не короче двух и не длиннее 45 символов")
    private String lname;

    @NotNull(message = "Факультет не может отсутствовать")
    @Min(value = 1, message = "Идентификатор факультета меньше нуля")
    private Integer faculty;

    @NotNull(message = "Специальность не может отсутствовать")
    @Min(value = 1, message = "Идентификатор специальности меньше нуля")
    private Integer speciality;

    @NotNull(message = "Группа не может отсутствовать")
    @Min(value = 100000, message = "Группа должна быть шестизначным числом")
    @Max(value = 999999, message = "Группа должна быть шестизначным числом")
    private Integer group;

    private String isBudget;

    @NotNull(message = "Средний балл не может отсутствовать")
    @Min(value = 4, message = "Средний балл не может быть меньше 4")
    @Max(value = 10, message = "Средний балл не может быть больше 10")
    private Double avgScore;

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public Integer getFaculty() {
        return faculty;
    }

    public void setFaculty(Integer faculty) {
        this.faculty = faculty;
    }

    public Integer getSpeciality() {
        return speciality;
    }

    public void setSpeciality(Integer speciality) {
        this.speciality = speciality;
    }

    public Integer getGroup() {
        return group;
    }

    public void setGroup(Integer group) {
        this.group = group;
    }

    public String getIsBudget() {
        return isBudget;
    }

    public void setIsBudget(String isBudget) {
        this.isBudget = isBudget;
    }

    public Double getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(Double avgScore) {
        this.avgScore = avgScore;
    }

    /*public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }*/
}
