<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Product" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>


<!DOCTYPE html>
<html>
<head>
    <title>QuickCart - Home</title>
    <style>
       /* -------------------- RESET & BODY -------------------- */
* { 
margin: 0; 
box-sizing: border-box; 
}

body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    font-family: 'Segoe UI', sans-serif;
    background: #f9f9f9;
}
.content { flex: 1; }

/* -------------------- HEADER -------------------- */
header {
    background-color: #fff;
    color: #222;
    padding: 15px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: sticky;
    top: 0;
    z-index: 999;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}

header h1 {
    font-size: 28px;
    color: #222;
    margin: 0;
}

/* -------------------- NAV BAR -------------------- */
nav {
    display: flex;
    align-items: center;
    gap: 30px;
}

nav a {
    font-weight: 500;
    color: #222;
    text-decoration: none;
    position: relative;
    padding: 8px 10px;
    margin-left: 50px;
    transition: color 0.3s ease;
}

nav a:hover {
    color: #ff5722;
    text-decoration: underline;
    
}

nav a.active {
    color: #ff5722;
    font-weight: bold;
    position: relative;
}



/* -------------------- DROPDOWN -------------------- */
.dropdown {
    position: relative;
    display: inline-block;
}

.dropbtn {
    font-weight: 500;
	margin-left: 50px;
	text-transform:uppercase;
    font-family: 'Segoe UI', sans-serif;
    background: none;
    border: none;
    color: #222;
    cursor: pointer;
    padding: 8px 0;
    transition: color 0.3s ease;
}

.dropbtn:hover {
    color: #ff5722;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 100px;
    box-shadow: 0px 8px 16px rgba(0,0,0,0.15);
    z-index: 1;
    border-radius: 5px;
    overflow: hidden;
}

.dropdown-content a {
    color: #222;
    padding: 10px 15px;
    text-align: center;
    text-decoration: none;
    display: block;
    transition: background 0.2s ease;
}

.dropdown-content a:hover {
    background-color: #f1f1f1;
}

.dropdown:hover .dropdown-content {
    display: block;
}

/* -------------------- PRODUCT CARD -------------------- */
.product-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    margin: 40px 20px;
    gap: 25px;
}

.product-image {
    width: 100%;
    height: 180px;
    object-fit: contain;
    padding: 10px;
}

.card {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    width: 250px;
    background-color: white;
    border-radius: 12px;
    box-shadow: 0 8px 16px rgba(0,0,0,0.15);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    overflow: hidden;
}

.card:hover {
    transform: translateY(-10px);
    box-shadow: 0 12px 25px rgba(0,0,0,0.25);
}

.card-body {
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    justify-content: space-between;
    padding: 15px;
    text-align: center;
}

.card h3 {
    margin-bottom: 10px;
    font-size: 20px;
    color: #333;
}

.price {
    font-size: 18px;
    color: green;
    font-weight: bold;
}

.explore-btn {
    margin-top: 10px;
    background-color: #1976d2;
    color: white;
    padding: 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.explore-btn:hover {
    background-color: #0d47a1;
}

/* -------------------- FOOTER -------------------- */
.footer {
    background-color: #333;
    color: white;
    padding: 20px;
    text-align: center;
}

.no-products {
    text-align: center;
    margin: 40px;
    font-size: 22px;
    color: #888;
}

.quickcart{
	color:black;
	cursor: pointer;
}

.quickcart:hover {
	color: #ff5722;
}
    </style>
</head>
<body>

    <header>
        <h1 class="quickcart">QuickCart</h1>
        <%
		    models.User user = (models.User) session.getAttribute("user");
		%>
		
		<nav>
		    <a href="" class="active">Home</a>
		    <a href="myOrders">My Cart</a>
		    <a href="cart">Cart</a>
		    
		    <% if (user != null && "admin".equals(user.getRole())) { %>
		        <a href="adminProducts">Admin Dashboard</a>
		    <% } %>
		    
		    <% if (user == null) { %>
		        <a href="signIn.jsp">Sign In</a>
		    <% } else { %>
		        <div class="dropdown">
		            <button class="dropbtn"><%= user.getName() %></button>
		            <div class="dropdown-content">
		            <a href="auth?action=logout">Logout</a>
		            </div>
		        </div>
		    <% } %>
		</nav>

    </header>
	<div class="content">
    <% if(products != null && !products.isEmpty()) { %>
        <div class="product-container">
            <% for(Product p : products) { %>
                <div class="card">
                <img src="<%= request.getContextPath() %>/<%= p.getImage() %>" class="product-image">
                    <div class="card-body">
                        <h3><%= p.getName() %></h3>
                        <div style="margin-top: auto;">
                        <p class="price">₹ <%= String.format("%.2f", p.getPrice()) %></p>
                        <form action="products" method="get">
						    <input type="hidden" name="id" value="<%= p.getId() %>"/>
						    <button class="explore-btn" type="submit">View</button>
						</form>
                    	</div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <div class="no-products">No products available at the moment.</div>
    <% } %>
</div>
    <div class="footer">
        &copy; 2025 QuickCart. Built with ❤️ by Mister_Hema_Sai
    </div>

</body>
</html>
