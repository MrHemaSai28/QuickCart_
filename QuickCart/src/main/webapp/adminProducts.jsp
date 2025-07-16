<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Product Management</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f0f2f5;
        }

        .container {
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-section {
            display: flex;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .preview-box {
            flex: 1;
            text-align: center;
            padding: 10px;
        }

        .preview-box img {
            width: 200px;
            height: auto;
            border: 1px solid #ccc;
            border-radius: 10px;
        }

        .form-box {
            flex: 2;
            padding-left: 20px;
        }

        .form-box label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        .form-box input[type="text"],
        .form-box input[type="number"],
        .form-box input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 4px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .form-box button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #1976d2;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .form-box button:hover {
            background-color: #0d47a1;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        td img {
            width: 60px;
            border-radius: 6px;
        }

        .popup {
            background-color: #d4edda;
            color: #155724;
            padding: 10px 20px;
            border: 1px solid #c3e6cb;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
            display: <%= (success != null && success.equals("1")) ? "block" : "none" %>;
        }
        .home-button {
	    display: inline-block;
	    margin-bottom: 15px;
	    padding: 8px 16px;
	    background-color: #4CAF50;
	    color: white;
	    text-decoration: none;
	    border-radius: 5px;
	    font-size: 14px;
	    transition: background-color 0.3s;
	}
	
	.home-button:hover {
	    background-color: #388E3C;
	}
        
        .delete-btn{
        	background-color: red;
        	color: white;
        	border-radius: 8px;
        	border: none;
        	padding: 10px;
        	cursor: pointer;
        }
        
        .delete-btn:hover{
        	padding: 9.7px;
        	background-color: #ff3333; 	
        }
        
        .edit-btn {
	    background-color: #1976d2;
	    color: white;
	    border-radius: 8px;
	    border: none;
	    padding: 10px;
	    cursor: pointer;
	    margin-left: 5px;
	}
	
	.edit-btn:hover {
	    background-color: #0d47a1;
	}
        
    </style>
</head>
<body>
<a href="products" class="home-button">← Visit Home Page</a>
<div class="container">
    <h2>Admin Panel – Manage Products</h2>

	<div class="popup" id="successPopup">✅ Product successfully added!</div>
	
    <div class="form-section">
        <div class="preview-box">
            <label>Preview:</label>
            <img id="previewImage" src="https://via.placeholder.com/200" alt="Image Preview">
        </div>

        <div class="form-box">
            <form action="adminProducts" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add" />

                <label>Name:</label>
                <input type="text" name="name" required />

                <label>Description:</label>
                <input type="text" name="description" style="height: 50px;" required />

                <label>Price:</label>
                <input type="number" name="price" step="0.01" required />

                <label>Category:</label>
                <input type="text" name="category" required />

                <label>Upload Image:</label>
                <input type="file" name="imageFile" onchange="previewFile()" required />

                <button type="submit">Add Product</button>
            </form>
        </div>
    </div>

    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Price</th><th>Category</th><th>Image</th><th colspan="2">Actions</th>
        </tr>
        <% for (Product p : products) { %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getName() %></td>
            <td>₹<%= p.getPrice() %></td>
            <td><%= p.getCategory() %></td>
            <td><img src="<%= p.getImage() %>" /></td>
            <td>
                <form action="adminProducts" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="id" value="<%= p.getId() %>" />
                    <button type="submit" class="delete-btn" onclick="return confirm('Delete this product?')">Delete</button>
                </form>
            </td>
            <td>
                <form action="<%= request.getContextPath() %>/editProduct.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= p.getId() %>" />
                    <button type="submit" class="edit-btn">Edit</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</div>

<script>
    function previewFile() {
        const preview = document.getElementById('previewImage');
        const file = document.querySelector('input[name=imageFile]').files[0];
        const reader = new FileReader();

        reader.addEventListener("load", function () {
            preview.src = reader.result;
        }, false);

        if (file) {
            reader.readAsDataURL(file);
        }
    }

    // Hide success popup after 3 seconds
    window.addEventListener("DOMContentLoaded", function () {
        const popup = document.getElementById("successPopup");
        if (popup && popup.style.display !== "none") {
            setTimeout(() => {
                popup.style.display = "none";
            }, 3000);
        }
    });
</script>

</body>
</html>
