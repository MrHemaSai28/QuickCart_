<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.CartItem" %>
<%@ page import="models.Product" %>
<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - QuickCart</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 30px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .cart-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 90%;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            animation: slideIn 0.5s ease forwards;
            opacity: 0;
        }

        @keyframes slideIn {
            from {
                transform: translateX(-40px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .product-img {
            width: 80px;
            height: 80px;
            object-fit: contain;
            border-radius: 6px;
            background-color: #f9f9f9;
            padding: 5px;
            border: 1px solid #ddd;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .product-img:hover {
            transform: scale(1.05);
        }

        .product-details {
            flex: 1;
            padding: 0 20px;
        }

        .product-name {
            font-size: 18px;
            font-weight: bold;
            color: #222;
        }

        .price-and-qty {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-top: 10px;
        }

        .price {
            color: green;
            font-weight: bold;
        }

        .qty-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .qty-btn {
            padding: 5px 10px;
            font-size: 14px;
            background: #1976d2;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .qty-btn:hover {
            background-color: #0d47a1;
        }

        input[type="number"] {
            width: 40px;
            text-align: center;
        }

        .remove-btn {
            background-color: #e53935;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .remove-btn:hover {
            background-color: #b71c1c;
        }

        .total {
            width: 90%;
            margin: 20px auto;
            font-size: 20px;
            text-align: right;
            color: #444;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .action-buttons a {
            background-color: #43a047;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .action-buttons a:hover {
            transform: scale(1.05);
            background-color: #2e7d32;
        }

        .empty-msg {
            text-align: center;
            color: #888;
            font-size: 18px;
            margin-top: 40px;
        }

        .goto-home {
	        position: fixed; 
	        top: 20px; 
	        left: 20px; 
	        background-color: #1976d2; 
	        color: white; 
	        padding: 8px 15px; 
	        border-radius: 6px; 
	        text-decoration: none; 
	        font-weight: bold; 
	        box-shadow: 0 2px 6px rgba(0,0,0,0.2); 
	        z-index: 999;"
        }

        .goto-home:hover {
            background-color: #0d47a1;
        }
    </style>
</head>
<body>

<a href="products" class="goto-home"> ← Home </a>
<h2>Your Shopping Cart 🛒</h2>

<% if (cartItems != null && !cartItems.isEmpty()) {
    double total = 0;
    int count = 0;
    for (CartItem c : cartItems) {
        Product p = c.getProduct();
        double itemTotal = p.getPrice() * c.getQuantity();
        total += itemTotal;
%>
    <div class="cart-card" style="animation-delay:<%= (count * 0.1) %>s">
        <form action="products" method="get">
            <input type="hidden" name="id" value="<%= p.getId() %>" />
            <button type="submit" style="border:none; background:none; padding:0; margin:0;">
                <img src="<%= request.getContextPath() + "/" + p.getImage() %>" alt="Image" class="product-img" />
            </button>
        </form>

        <div class="product-details">
            <span class="product-name"><%= p.getName() %></span>
            <div class="price-and-qty">
                <span class="price">₹ <%= String.format("%.2f", p.getPrice()) %></span>
                <div class="qty-control">
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="cartId" value="<%= c.getId() %>">
                        <input type="hidden" name="quantity" value="<%= c.getQuantity() - 1 %>">
                        <button class="qty-btn">−</button>
                    </form>

                    <input type="number" value="<%= c.getQuantity() %>" readonly />

                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="cartId" value="<%= c.getId() %>">
                        <input type="hidden" name="quantity" value="<%= c.getQuantity() + 1 %>">
                        <button class="qty-btn">+</button>
                    </form>
                </div>
            </div>
        </div>

        <div>
            <div style="margin-bottom: 10px;"><strong>Total:</strong> ₹ <%= String.format("%.2f", itemTotal) %></div>
            <form action="cart" method="post">
                <input type="hidden" name="action" value="remove">
                <input type="hidden" name="cartId" value="<%= c.getId() %>">
                <button type="submit" class="remove-btn">Remove</button>
            </form>
        </div>
    </div>
<%
        count++;
    } // end for
%>

<div class="total"><strong>Grand Total:</strong> ₹ <%= String.format("%.2f", total) %></div>
<div class="action-buttons">
    <a href="products" style="background-color:#1976d2;">Add More Items</a>
    <a href="address">Place Order</a>
</div>

<% } else { %>
    <div class="empty-msg">Your cart is empty ☹️</div>
<% } %>

</body>
</html>
