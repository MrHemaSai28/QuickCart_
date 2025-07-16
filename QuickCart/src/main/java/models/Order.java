package models;
import java.util.*;

public class Order {
    private int id;
    private int userId;
    private Date orderDate;
    private double totalAmount;
    private List<OrderItem> items;
    private String address;
    private String paymentType;
    private String trackingStatus;

	public String getTrackingStatus() {
		return trackingStatus;
	}
	public void setTrackingStatus(String trackingStatus) {
		this.trackingStatus = trackingStatus;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public List<OrderItem> getItems() {
		return items;
	}
	public void setItems(List<OrderItem> items) {
		this.items = items;
	}
    
	public String getAddress() {
	    return address;
	}
	public void setAddress(String address) {
	    this.address = address;
	}

	public String getPaymentType() {
	    return paymentType;
	}
	public void setPaymentType(String paymentType) {
	    this.paymentType = paymentType;
	}

    
}
