package com.sdutcm.wm.pojo;

import java.util.Date;

public class RiderCompletedOrder {
    private String orderOn;
    private String riderId;
    private Double deliveryDistance;
    private Integer deliveryDuration;
    private Double deliveryFee;
    private Date completionTime;

    // Getters and Setters
    public String getOrderOn() {
        return orderOn;
    }

    public void setOrderOn(String orderOn) {
        this.orderOn = orderOn;
    }

    public String getRiderId() {
        return riderId;
    }

    public void setRiderId(String riderId) {
        this.riderId = riderId;
    }

    public Double getDeliveryDistance() {
        return deliveryDistance;
    }

    public void setDeliveryDistance(Double deliveryDistance) {
        this.deliveryDistance = deliveryDistance;
    }

    public Integer getDeliveryDuration() {
        return deliveryDuration;
    }

    public void setDeliveryDuration(Integer deliveryDuration) {
        this.deliveryDuration = deliveryDuration;
    }

    public Double getDeliveryFee() {
        return deliveryFee;
    }

    public void setDeliveryFee(Double deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public Date getCompletionTime() {
        return completionTime;
    }

    public void setCompletionTime(Date completionTime) {
        this.completionTime = completionTime;
    }
} 