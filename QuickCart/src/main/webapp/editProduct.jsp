<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Product" %>
<%@ page import="daoImp.ProductDaoImp" %>
<%@ page import="dao.ProductDao" %>

<%
    String idParam = request.getParameter("id");
    Product product = null;

    if (idParam != null) {
        int id = Integer.parseInt(idParam);
        ProductDao dao = new ProductDaoImp();
        product = dao.getProductById(id);
    }

    if (product == null) {
%>
    <h2 style="color:red; text-align:center;">Product not found!</h2>
    <a href="adminProducts" style="text-align:center; display:block;">Back to Admin Panel</a>
<%
    return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f0f2f5;
        }

        .container {
            max-width: 700px;
            margin: auto;
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            margin-top: 20px;
            padding: 12px 20px;
            background-color: #43a047;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #2e7d32;
        }

        .preview {
            margin-top: 10px;
            text-align: center;
        }

        .preview img {
            width: 200px;
            border-radius: 10px;
            border: 1px solid #ddd;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #1976d2;
            text-decoration: none;
        }
    </style>
</head>
<body>

<a href="adminProducts" class="back-link">← Back to Admin Panel</a>

<div class="container">
    <h2>Edit Product</h2>

    <form action="adminProducts" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" name="id" value="<%= product.getId() %>" />

        <label>Name:</label>
        <input type="text" name="name" value="<%= product.getName() %>" required />

        <label>Description:</label>
        <input type="text" name="description" value="<%= product.getDescription() %>" required />

        <label>Price:</label>
        <input type="number" name="price" step="0.01" value="<%= product.getPrice() %>" required />

        <label>Category:</label>
        <input type="text" name="category" value="<%= product.getCategory() %>" required />

        <label>Current Image:</label>
        <div class="preview">
            <img src="<%= request.getContextPath() %>/<%= product.getImage() %>" id="currentImage" />
        </div>

        <label>Upload New Image (optional):</label>
        <input type="file" name="imageFile" onchange="previewNewImage()" />

        <div class="preview" id="newImagePreview" style="display:none;">
            <p>New Image Preview:</p>
            <img id="previewImage" />
        </div>

        <button type="submit">Update Product</button>
    </form>
</div>

<script>
    function previewNewImage() {
        const previewBox = document.getElementById("newImagePreview");
        const preview = document.getElementById("previewImage");
        const file = document.querySelector('input[name=imageFile]').files[0];
        const reader = new FileReader();

        reader.addEventListener("load", function () {
            preview.src = reader.result;
            previewBox.style.display = "block";
        }, false);

        if (file) {
            reader.readAsDataURL(file);
        }
    }
</script>

</body>
</html>
