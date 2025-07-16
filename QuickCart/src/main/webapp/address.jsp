<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="models.User, models.Address" %>
<%@ page import="java.util.List" %>

<%
    List<Address> addressList = (List<Address>) request.getAttribute("addressList");
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("signIn.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Address & Payment - QuickCart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: #1976d2;
        }

        .address-container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .address-box {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
        }

        .address-box:hover {
            background-color: #f1f1f1;
        }

        input[type="radio"] {
            margin-right: 10px;
        }

        .edit-btn {
            float: right;
            background: #1976d2;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
        }

        .add-new-btn {
            display: inline-block;
            background: #43a047;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 6px;
            margin-top: 10px;
        }

        select, button {
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            background: #43a047;
            color: white;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background: #2e7d32;
        }
        
        .payment{
        	margin-bottom: 0px;
        	margin-top: 10px;
        	font-size: 1.3rem;
        }
    </style>
</head>
<body>

<h2>Choose Delivery Address & Payment</h2>

<div class="address-container">
    <form action="placeOrder" method="post">

    <% if (request.getAttribute("buyNow") != null && request.getAttribute("productId") != null) { %>
        <input type="hidden" name="buyNow" value="true" />
        <input type="hidden" name="productId" value="<%= request.getAttribute("productId") %>" />
    <% } %>

    <% if (addressList != null && !addressList.isEmpty()) {
        for (Address a : addressList) {
    %>
        <div class="address-box">
            <label>
                <input type="radio" name="addressId" value="<%= a.getId() %>" required />
                <strong><%= a.getName() %></strong><br/>
                <%= a.getPhone() %><br/>
                <%= a.getStreet() %>, <%= a.getLandmark() != null ? a.getLandmark() : "" %><br/>
                <%= a.getCity() %> - <%= a.getPincode() %><br/>
                <%= a.getState() %>
            </label>
        </div>
    <%  }
    } else { %>
        <p>No saved addresses found.</p>
    <% } %>

    <% if (addressList == null || addressList.size() < 5) { %>
        <a class="add-new-btn" href="addressForm.jsp">+ Add New Address</a><br>
    <% } %>

    <h6 class="payment">Payment Method</h6>
    <select name="payment" required>
        <option value="COD">Cash on Delivery</option>
        <option value="UPI">UPI</option>
        <option value="Card">Credit/Debit Card</option>
    </select>

    <button type="submit">Continue & Place Order</button>
</form>

</div>

</body>
</html>
