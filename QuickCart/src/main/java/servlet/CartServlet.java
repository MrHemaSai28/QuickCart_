package servlet;

import dao.CartDao;
import daoImp.CartDaoImp;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.CartItem;
import models.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDao cartDao;

    @Override
    public void init() {
        cartDao = new CartDaoImp();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("signIn.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<CartItem> cartItems = cartDao.getUserCart(user.getId());
        req.setAttribute("cartItems", cartItems);
        req.getRequestDispatcher("cart.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("signIn.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        try {
            switch (action) {
                case "add": {
                    int productId = Integer.parseInt(req.getParameter("productId"));
                    cartDao.addToCart(userId, productId);
                    // Redirect back to product page with cart=1 (for popup)
//                    res.sendRedirect("products?id=" + productId + "&cart=1");
                    res.sendRedirect("cart");
                    break;
                }
                case "buyNow": {
                	int productId = Integer.parseInt(req.getParameter("productId"));
                	cartDao.addToCart(userId, productId);
                	res.sendRedirect("cart"); // or redirect to "checkout.jsp" if you have it
                	break;
                }
                case "remove": {
                    int cartId = Integer.parseInt(req.getParameter("cartId"));
                    cartDao.removeCartItem(cartId);
                    res.sendRedirect("cart");
                    break;
                }
                case "update": {
                    int cartId = Integer.parseInt(req.getParameter("cartId"));
                    int quantity = Integer.parseInt(req.getParameter("quantity"));

                    if (quantity > 0) {
                        cartDao.updateCartQuantity(cartId, quantity);
                    } else {
                        cartDao.removeCartItem(cartId); // Remove if 0 or less
                    }
                    res.sendRedirect("cart");
                    break;
                }
                
                default:
                    res.sendRedirect("cart");
                    break;
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            res.sendRedirect("cart?error=InvalidInput");
        }
    }
}
