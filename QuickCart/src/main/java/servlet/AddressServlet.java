package servlet;

import dao.AddressDao;
import daoImp.AddressDaoImp;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Address;
import models.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/address")
public class AddressServlet extends HttpServlet {
    private AddressDao addressDao = new AddressDaoImp();

    // Cart.jsp → Place Order → GET → show address.jsp or addressForm.jsp
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("signIn.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        List<Address> addressList = addressDao.getAllAddressesByUserId(user.getId());
        
        String buyNowParam = req.getParameter("buyNow");
        String productId = req.getParameter("productId");

        if (buyNowParam != null && productId != null) {
            req.setAttribute("buyNow", true);
            req.setAttribute("productId", productId);
        }
        
        if (addressList != null && !addressList.isEmpty()) {
            // ✅ Show selection page with payment
            req.setAttribute("addressList", addressList);
            req.getRequestDispatcher("address.jsp").forward(req, res);
        } else {
            // 🆕 No saved addresses — go to address form
            res.sendRedirect("addressForm.jsp");
        }
    }

    // From addressForm.jsp → POST → Save Address → Forward to placeOrder
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("signIn.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Prepare Address object
        Address a = new Address();
        a.setUserId(user.getId());
        a.setName(req.getParameter("name"));
        a.setPhone(req.getParameter("phone"));
        a.setStreet(req.getParameter("street"));
        a.setLandmark(req.getParameter("landmark"));
        a.setCity(req.getParameter("city"));
        a.setState(req.getParameter("state"));
        a.setPincode(req.getParameter("pincode"));

        // Save address
        boolean success = addressDao.saveAddress(a);

        if (success) {
            // Send back to address.jsp to choose + pay
            res.sendRedirect("address"); // this will call doGet again and show updated list
        } else {
            req.setAttribute("error", "Failed to save address.");
            req.getRequestDispatcher("addressForm.jsp").forward(req, res);
        }
    }
}
