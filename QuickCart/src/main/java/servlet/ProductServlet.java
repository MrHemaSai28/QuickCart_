package servlet;

import dao.ProductDao;
import daoImp.ProductDaoImp;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Product;
import models.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductDao dao;

    @Override
    public void init() throws ServletException {
        dao = new ProductDaoImp();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        System.out.println("ProductServlet: doGet triggered");

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Product product = dao.getProductById(id);

                req.setAttribute("product", product);

                // 💡 Load recommended products based on category, excluding current product
                List<Product> recommended = dao.getRecommendedProducts(product.getCategory(), id);
                req.setAttribute("recommended", recommended);

                req.getRequestDispatcher("productDetail.jsp").forward(req, res);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // If no product ID, show all products
        List<Product> productList = dao.getAllProducts();
        req.setAttribute("products", productList);
        RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
        rd.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        String category = req.getParameter("category");

        Product p = new Product();
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);
        p.setCategory(category);

        boolean result = dao.addProduct(p);
        
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
//            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access denied.");
        	res.sendRedirect("adminProducts");
            return;
        }


        if (result) {
            res.sendRedirect("products");
        } else {
            res.sendRedirect("product.jsp?error=1");
        }
    }
}
