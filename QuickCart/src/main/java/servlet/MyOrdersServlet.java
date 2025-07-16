package servlet;

import dao.OrderDao;
import daoImp.OrderDaoImp;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Order;
import models.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/myOrders")
public class MyOrdersServlet extends HttpServlet {
    private OrderDao orderDao = new OrderDaoImp();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("signIn.jsp");
            return;
        }
        
        orderDao.autoUpdateDeliveredStatus(); 
        User user = (User) session.getAttribute("user");
        List<Order> orders = orderDao.getOrdersByUserId(user.getId());
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("myOrders.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("signIn.jsp");
            return;
        }

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String reason = req.getParameter("reason");
        String customReason = req.getParameter("customReason");

        // Final reason (custom text if "Other" selected and provided)
        String finalReason = reason;
        if ("Other".equals(reason) && customReason != null && !customReason.trim().isEmpty()) {
            finalReason = customReason.trim();
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        // Call new method with reason
        orderDao.trackOrder(orderId, "Cancelled", userId, finalReason);
        res.sendRedirect("myOrders?msg=cancelled");
        System.out.println("Cancelled order ID: " + orderId);
    }

}
