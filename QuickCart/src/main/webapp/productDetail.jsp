<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Product"%>
<%@ page import="models.User"%>
<%@ page import="java.util.List"%>

<%
    Product p = (Product) request.getAttribute("product");
    List<Product> recommended = (List<Product>) request.getAttribute("recommended");
    User currentUser = (User) session.getAttribute("user");
    String role = currentUser != null ? currentUser.getRole() : "guest";
%>
<!DOCTYPE html>
<html>
<head>
<title><%= p.getName() %> - QuickCart</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

html, body {
	font-family: 'Segoe UI', sans-serif;
	background: #f9f9f9;
}

.fullscreen-container {
	display: flex;
	min-height: 80vh;
	align-items: center;
	justify-content: center;
	padding: 40px;
}

.product-box {
	display: flex;
	max-width: 1200px;
	width: 100%;
	background-color: white;
	border-radius: 16px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
	overflow: hidden;
}

.product-image {
	flex: 1;
	background-color: #eee;
	display: flex;
	align-items: center;
	justify-content: center;
}

.product-image img {
	max-width: 100%;
	height: auto;
	padding: 30px;
	border-radius: 12px;
}

.product-details {
	flex: 1;
	padding: 40px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.product-details h2 {
	font-size: 36px;
	color: #222;
	margin-bottom: 20px;
}

.price {
	font-size: 28px;
	color: green;
	font-weight: bold;
	margin-bottom: 20px;
}

.product-details p {
	font-size: 18px;
	color: #555;
	margin-bottom: 12px;
}

.btn-group {
	margin-top: 30px;
	display: flex;
	gap: 20px;
}

.btn {
	padding: 14px 28px;
	font-size: 16px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background 0.3s ease;
}

.add-btn {
	background-color: #1976d2;
	color: white;
}

.add-btn:hover {
	background-color: #0d47a1;
}

.buy-btn {
	background-color: #43a047;
	color: white;
}

.buy-btn:hover {
	background-color: #2e7d32;
}

.back-link {
	position: absolute;
	top: 30px;
	left: 30px;
	text-decoration: none;
	background-color: #4682A9;
	font-size: 16px;
	color: white;
	padding: 10px;
	border-radius: 8px;
}

.back-link:hover {
	background-color: #2A629A;
}

.recommended-container {
	padding: 40px;
}

.recommended-title {
	font-size: 24px;
	margin-bottom: 20px;
	color: #222;
	margin-left: 20px;
}

.recommended-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
}

.recommended-card {
	width: 200px;
	background: #fff;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.recommended-card img {
	width: 100%;
	height: 150px;
	object-fit: contain;
	margin-bottom: 10px;
}

.recommended-card h4 {
	font-size: 18px;
	margin-bottom: 6px;
}

.recommended-card p {
	color: green;
	font-weight: bold;
	margin-bottom: 8px;
}

.recommended-card button {
	padding: 6px 12px;
	border: none;
	background-color: #1976d2;
	color: white;
	border-radius: 6px;
	cursor: pointer;
}

.recommended-card button:hover {
	background-color: #0d47a1;
}
</style>
</head>
<body>

	<a class="back-link" href="products">← Home</a>

	<!-- Product Section -->
	<div class="fullscreen-container">
		<div class="product-box">
			<div class="product-image">
				<img src="<%= request.getContextPath() %>/<%= p.getImage() %>"
					alt="Product Image">
			</div>
			<div class="product-details">
				<h2><%= p.getName() %></h2>
				<div class="price">
					₹
					<%= String.format("%.2f", p.getPrice()) %></div>
				<p>
					<strong>Description:</strong>
					<%= p.getDescription() %></p>
				<p>
					<strong>Category:</strong>
					<%= p.getCategory() %></p>

				<% if (!"admin".equals(role)) { %>
				<div class="btn-group">
					<form action="cart" method="post">
						<input type="hidden" name="action" value="add"> 
						<input type="hidden" name="productId" value="<%= p.getId() %>">
						<button type="submit" class="btn add-btn">Add to Cart</button>
					</form>
					<form action="address" method="get">
					    <input type="hidden" name="buyNow" value="true" />
					    <input type="hidden" name="productId" value="<%= p.getId() %>" />
					    <button class="btn buy-btn" type="submit">Buy Now</button>
					</form>
				</div>
				<% } else { %>
				<p style="color: gray; margin-top: 20px;">(Admin view - purchasing disabled)</p>
				<% } %>
			</div>
		</div>
	</div>

	<!-- Recommended Products Section -->
	<% if (recommended != null && !recommended.isEmpty()) { %>
	<h2 style="margin: 30px 0 15px 40px;">Recommended for You 💡</h2>
	<marquee behavior="scroll" direction="left" scrollamount="5"
		onmouseover="this.stop();" onmouseout="this.start();">
		<div style="display: flex; gap: 20px; padding: 10px 40px;">
			<% for (Product rp : recommended) { %>
			<div
				style="width: 200px; border: 1px solid #ddd; padding: 10px; border-radius: 10px; background: #fff; margin-right: 20px; text-align: center;">
				<img src="<%= request.getContextPath() %>/<%= rp.getImage() %>"
					style="width: 100%; height: 150px; object-fit: contain;" />
				<h3 style="font-size: 18px;"><%= rp.getName() %></h3>
				<p style="color: green;">
					₹
					<%= rp.getPrice() %></p>
				<form action="products" method="get">
					<input type="hidden" name="id" value="<%= rp.getId() %>">
					<button type="submit"
						style="padding: 6px 12px; border: none; background: #1976d2; color: white; border-radius: 6px;">View</button>
				</form>
			</div>
			<% } %>
		</div>
	</marquee>
	<% } %>

</body>
</html>
