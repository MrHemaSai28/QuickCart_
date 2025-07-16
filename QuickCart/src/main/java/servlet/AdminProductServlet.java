package servlet;

import dao.ProductDao;
import daoImp.ProductDaoImp;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Product;
import models.User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet("/adminProducts")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,  // 1 MB
                                    maxFileSize = 5 * 1024 * 1024,     // 5 MB
                                    maxRequestSize = 10 * 1024 * 1024) // 10 MB
public class AdminProductServlet extends HttpServlet {
    private ProductDao dao = new ProductDaoImp();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equals(user.getRole())) {
            res.sendRedirect("../signIn.jsp");
            return;
        }

        List<Product> productList = dao.getAllProducts();
        req.setAttribute("products", productList);
        req.getRequestDispatcher("adminProducts.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Product p = new Product();
            p.setName(req.getParameter("name"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setCategory(req.getParameter("category"));

            Part filePart = req.getPart("imageFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = getServletContext().getRealPath("/") + "images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);
            p.setImage("images/" + fileName);

            dao.addProduct(p);

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteProduct(id);

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product p = dao.getProductById(id);
            if (p != null) {
                p.setName(req.getParameter("name"));
                p.setDescription(req.getParameter("description"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setCategory(req.getParameter("category"));

                Part filePart = req.getPart("imageFile");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("/") + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    filePart.write(uploadPath + File.separator + fileName);
                    p.setImage("images/" + fileName);
                }

                dao.updateProduct(p);
            }
        }

        res.sendRedirect("adminProducts?success=1");
    }
}
