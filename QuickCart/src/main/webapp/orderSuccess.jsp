<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, models.CartItem" %>
<%
    int orderId = (int) request.getAttribute("orderId");
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    double total = (double) request.getAttribute("totalAmount");
    String address = (String) request.getAttribute("address");
    String payment = (String) request.getAttribute("paymentType");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation - QuickCart</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f1f1f1;
            padding: 40px;
        }

        .container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            max-width: 800px;
            margin: auto;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            animation: fadeIn 1s ease;
        }

        h2 {
            color: green;
            text-align: center;
            margin-bottom: 20px;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        ul li {
            padding: 8px 0;
            border-bottom: 1px solid #ccc;
        }

        .info {
            margin: 20px 0;
        }

        .btn {
            margin-top: 30px;
            display: inline-block;
            padding: 12px 24px;
            background: #1976d2;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 16px;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn:hover {
            background-color: #0d47a1;
            transform: scale(1.05);
        }

        /* Delivery Animation Section */
        .delivery-section {
            margin-top: 40px;
            text-align: center;
        }

        .delivery-steps {
            display: flex;
            justify-content: space-between;
            max-width: 700px;
            margin: auto;
            margin-bottom: 20px;
            font-size: 16px;
            color: #333;
        }

        .step {
            flex: 1;
            padding: 10px;
            border-radius: 6px;
            background: #e3f2fd;
            margin: 0 5px;
            position: relative;
        }

        .step.active {
            background: #c8e6c9;
            font-weight: bold;
        }

        .road {
            position: relative;
            height: 60px;
            background: #b0bec5;
            border-radius: 30px;
            overflow: hidden;
            max-width: 700px;
            margin: auto;
        }

        .truck {
            position: absolute;
            top: 10px;
            left: -80px;
            font-size: 32px;
            animation: moveTruck 4s ease-in-out infinite;
        }

        @keyframes moveTruck {
            0% { left: -80px; }
            30% { left: 150px; }
            60% { left: 350px; }
            100% { left: 650px; }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🎉 Your Order has been Placed Successfully!</h2>
    <p style="text-align:center;">🧾 Order ID: <strong>#<%= orderId %></strong></p>

    <div class="info">
        <h3>🛒 Items:</h3>
        <ul>
            <% for (CartItem item : cartItems) { %>
                <li><%= item.getProduct().getName() %> (Qty: <%= item.getQuantity() %>) - ₹<%= item.getProduct().getPrice() %></li>
            <% } %>
        </ul>
    </div>

    <p><strong>💰 Total Amount:</strong> ₹<%= String.format("%.2f", total) %></p>
    <p><strong>📬 Shipping Address:</strong> <%= address %></p>
    <p><strong>💳 Payment Method:</strong> <%= payment %></p>

    <!-- Delivery Progress Animation -->
    <div class="delivery-section">
        <div class="delivery-steps">
            <div class="step active">📦 Order Placed</div>
            <div class="step active">📦 Packed</div>
            <div class="step active">🚚 Out for Delivery</div>
            <div class="step active">✅ Delivered</div>
        </div>

        <div class="road">
            <div class="truck">🚚</div>
        </div>
    </div>

    <div style="text-align:center;">
        <a class="btn" href="products">Continue Shopping</a>
    </div>
</div>
</body>
</html>
