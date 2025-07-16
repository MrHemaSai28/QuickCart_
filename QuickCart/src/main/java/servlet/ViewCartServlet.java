package servlet;

import dao.CartDao;
import daoImp.CartDaoImp;
import models.CartItem;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ViewCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("userId");

        CartDao dao = new CartDaoImp();
        List<CartItem> cart = dao.getUserCart(userId);

        req.setAttribute("cartItems", cart);
        RequestDispatcher rd = req.getRequestDispatcher("cart.jsp");
        rd.forward(req, res);
    }
}
