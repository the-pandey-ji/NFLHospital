package com.entity;

public class EndUser {

    private String empn;
    private String username;
    private String designation;
    private int age;
    private String sex;
    private String department; // <-- Corrected field declaration

    // --- Constructors ---
    public EndUser() {
        super();
    }

    // Corrected Parameterized Constructor to include department
    public EndUser(String empn, String username, String designation, int age, String sex, String department) {
        this.empn = empn;
        this.username = username;
        this.designation = designation;
        this.age = age;
        this.sex = sex;
        this.department = department; // <-- Added
    }

    // --- Getters and Setters ---
    public String getEmpn() {
        return empn;
    }

    public void setEmpn(String empn) {
        this.empn = empn;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    // --- Added Getter and Setter for department ---
    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    // --- toString() for debugging ---
    @Override
    public String toString() {
        return "EndUser{" +
                "empn='" + empn + '\'' +
                ", username='" + username + '\'' +
                ", designation='" + designation + '\'' +
                ", age=" + age +
                ", sex='" + sex + '\'' +
                ", department='" + department + '\'' + // <-- Added
                '}';
    }
}