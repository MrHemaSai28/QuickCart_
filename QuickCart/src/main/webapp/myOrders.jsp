<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Order, models.OrderItem, models.Product" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f2f2f2;
            padding: 30px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .order-card {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .order-card:hover {
            transform: translateY(-5px);
        }

        .order-header {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #444;
        }

        .order-info {
            font-size: 15px;
            margin-bottom: 15px;
        }

        .order-info span {
            margin-right: 20px;
        }

        .item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .item:hover {
            background-color: #e9f5ff;
        }

        .item img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 15px;
        }

        .item-details p {
            margin: 3px 0;
        }

        .status-tag {
            padding: 2px 10px;
            border-radius: 5px;
            font-size: 13px;
            font-weight: 500;
            color: white;
        }

        .cancel-btn {
            background-color: #e53935;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .cancel-form {
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 8px;
            margin-top: 10px;
        }

        .no-orders {
            text-align: center;
            font-size: 18px;
            color: #888;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<a href="products" style="position: fixed; top: 20px; left: 20px; background-color: #1976d2; color: white; padding: 8px 15px; border-radius: 6px; text-decoration: none; font-weight: bold;">
    ← Home
</a>

<h2>My Orders</h2>

<%
    if (orders != null && !orders.isEmpty()) {
        for (Order order : orders) {
            String status = order.getTrackingStatus();
            String statusColor = "gray";
            if ("Preparing".equalsIgnoreCase(status)) statusColor = "orange";
            else if ("Out for delivery".equalsIgnoreCase(status)) statusColor = "blue";
            else if ("Delivered".equalsIgnoreCase(status)) statusColor = "green";
            else if ("Cancelled".equalsIgnoreCase(status)) statusColor = "red";
            else if ("Confirmed".equalsIgnoreCase(status)) statusColor = "skyblue";
%>
    <div class="order-card">
        <div class="order-header">
            Order ID: <%= order.getId() %> | ₹<%= order.getTotalAmount() %>
        </div>

        <div class="order-info">
            <span><b>Payment:</b> <%= order.getPaymentType() %></span>
            <span><b>Date:</b> <%= order.getOrderDate() %></span>
            <span><b>Status:</b> <span class="status-tag" style="background-color:<%= statusColor %>;"><%= status %></span></span>
            <span><b>Shipping:</b> <%= order.getAddress() %></span>
        </div>

        <!-- Order Items -->
        <% for (OrderItem item : order.getItems()) {
            Product p = item.getProduct();
        %>
            <a href="products?id=<%= p.getId() %>" style="text-decoration: none; color: inherit;" target="_blank">
                <div class="item" style="cursor: pointer;">
                    <img src="<%= p.getImage() %>" />
                    <div class="item-details">
                        <p><b><%= p.getName() %></b></p>
                        <p>Qty: <%= item.getQuantity() %> | ₹<%= item.getPrice() %></p>
                    </div>
                </div>
            </a>
        <% } %>

        <!-- Cancel Section at Bottom -->
        <div style="margin-top: 20px;">
            <% if (!"Delivered".equalsIgnoreCase(status) && !"Cancelled".equalsIgnoreCase(status)) { %>
                <button onclick="showCancelForm(<%= order.getId() %>)" class="cancel-btn">Cancel Order</button>
            <% } %>

            <div id="cancelForm-<%= order.getId() %>" class="cancel-form" style="display:none;">
                <form action="myOrders" method="post">
                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                    <label>Reason:</label>
                    <select name="reason" required>
                        <option value="">-- Select --</option>
                        <option value="Changed my mind">Changed my mind</option>
                        <option value="Ordered by mistake">Ordered by mistake</option>
                        <option value="Found better price">Found better price</option>
                        <option value="Other">Other</option>
                    </select><br/>
                    <textarea name="customReason" placeholder="Additional info (optional)" rows="2" style="width:100%; margin-top:5px;"></textarea>
                    <button type="submit" style="margin-top:5px;">Submit</button>
                </form>
            </div>
        </div>
    </div>
<%
        }
    } else {
%>
    <div class="no-orders">No orders found.</div>
<%
    }
%>

<script>
    function showCancelForm(orderId) {
        document.querySelectorAll('[id^="cancelForm-"]').forEach(div => div.style.display = 'none');
        document.getElementById("cancelForm-" + orderId).style.display = 'block';
    }
</script>

</body>
</html>
