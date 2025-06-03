/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Phạm Quốc Tuấn
 */
import java.util.Date;

public class Promotion {
    private int id;
    private String title;
    private double percentage;
    private Date startAt;
    private Date endAt;
    private String description;

    public Promotion() {}

    public Promotion(int id, String title, double percentage, Date startAt, Date endAt, String description) {
        this.id = id;
        this.title = title;
        this.percentage = percentage;
        this.startAt = startAt;
        this.endAt = endAt;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }

    public Date getStartAt() {
        return startAt;
    }

    public void setStartAt(Date startAt) {
        this.startAt = startAt;
    }

    public Date getEndAt() {
        return endAt;
    }

    public void setEndAt(Date endAt) {
        this.endAt = endAt;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    

    @Override
    public String toString() {
        return "Promotion{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", percentage=" + percentage +
                ", startAt=" + startAt +
                ", endAt=" + endAt +
                ", description='" + description + '\'' +
                '}';
    }
}