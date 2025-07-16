<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("signIn.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add New Address</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f0f0;
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: #1976d2;
        }

        form {
            max-width: 500px;
            margin: auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            margin-top: 20px;
            padding: 12px;
            background-color: #43a047;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        button:hover {
            background-color: #2e7d32;
        }
    </style>
</head>
<body>

<h2>Add New Delivery Address</h2>

<form action="address" method="post">
    <label>Full Name</label>
    <input type="text" name="name" required>

    <label>Phone</label>
    <input type="text" name="phone" required>

    <label>Street</label>
    <input type="text" name="street" required>

    <label>Landmark</label>
    <input type="text" name="landmark">

    <label>City</label>
    <input type="text" name="city" required>

    <label>State</label>
    <input type="text" name="state" required>

    <label>Pincode</label>
    <input type="text" name="pincode" required>

    <button type="submit">Save Address</button>
</form>

</body>
</html>
