package com.netcracker.devschool.dev4.studdist.form;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class HeadOfPracticeForm {


    @NotNull(message = "Электронная почта не может отсутствовать")
    @Size(min = 2, max = 45, message = "Электронная почта должна быть не короче двух и не длиннее 45 символов")
    private String email;

    @NotNull(message = "Пароль не может отсутствовать")
    @Size(min = 6, message = "Пароль должен быть длиннее 6 символов")
    private String password;

    @NotNull(message = "Название компании не может отсутствовать")
    @Size(min = 2, max = 45, message = "Название компании должно быть не короче двух и не длиннее 45 символов")
    private String companyName;

    @NotNull(message = "Имя не может отсутствовать")
    @Size(min = 2, max = 45, message = "Имя должно быть не короче двух и не длиннее 45 символов")
    private String fname;

    @NotNull(message = "Фамилия не может отсутствовать")
    @Size(min = 2, max = 45, message = "Фамилия должна быть не короче двух и не длиннее 45 символов")
    private String lname;

    public String getEmail() {
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
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

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
}
