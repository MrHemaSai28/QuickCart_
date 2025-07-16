package servlet;

import dao.AddressDao;
import dao.CartDao;
import dao.OrderDao;
import dao.ProductDao;
import daoImp.AddressDaoImp;
import daoImp.CartDaoImp;
import daoImp.OrderDaoImp;
import daoImp.ProductDaoImp;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Address;
import models.CartItem;
import models.Product;
import models.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {
    private CartDao cartDao = new CartDaoImp();
    private OrderDao orderDao = new OrderDaoImp();
    private AddressDao addressDao = new AddressDaoImp();
    private ProductDao productDao = new ProductDaoImp(); // ✅ Required for Buy Now

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("signIn.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        String addressIdParam = req.getParameter("addressId");
        String paymentType = req.getParameter("payment");

        String fullAddress = "";

        if (addressIdParam != null && !addressIdParam.isEmpty()) {
            int addressId = Integer.parseInt(addressIdParam);
            Address selectedAddress = addressDao.getAddressById(addressId);
            if (selectedAddress != null) {
                fullAddress = selectedAddress.getName() + ", " +
                        selectedAddress.getPhone() + ", " +
                        selectedAddress.getStreet() + ", " +
                        (selectedAddress.getLandmark() != null ? selectedAddress.getLandmark() + ", " : "") +
                        selectedAddress.getCity() + ", " +
                        selectedAddress.getState() + " - " +
                        selectedAddress.getPincode();
            } else {
                req.setAttribute("error", "Invalid address selected.");
                req.getRequestDispatcher("address.jsp").forward(req, res);
                return;
            }
        }

        // Check if it's a "Buy Now" action
        String buyNowParam = req.getParameter("buyNow");
        String productIdParam = req.getParameter("productId");

        List<CartItem> cart = new ArrayList<>();
        double total = 0;

        if ("true".equalsIgnoreCase(buyNowParam) && productIdParam != null) {
            try {
                int productId = Integer.parseInt(productIdParam);
                Product product = productDao.getProductById(productId);

                if (product == null) {
                    req.setAttribute("error", "Product not found.");
                    req.getRequestDispatcher("products").forward(req, res);
                    return;
                }

                CartItem item = new CartItem();
                item.setProduct(product);
                item.setQuantity(1);
                cart.add(item);

                total = product.getPrice(); // ✅ Single product price

            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid product.");
                req.getRequestDispatcher("products").forward(req, res);
                return;
            }
        } else {
            // Regular cart flow
            cart = cartDao.getUserCart(userId);
            for (CartItem c : cart) {
                total += c.getProduct().getPrice() * c.getQuantity();
            }
        }

        // ✅ Create order
        int orderId = orderDao.createOrder(userId, fullAddress, paymentType, total);
        if (orderId > 0) {
            for (CartItem c : cart) {
                orderDao.addOrderItem(orderId, c.getProduct().getId(), c.getQuantity(), c.getProduct().getPrice());
            }

            orderDao.trackOrder(orderId, "Order Placed");

            // Clear cart ONLY if it was a normal cart checkout
            if (buyNowParam == null) {
                cartDao.clearUserCart(userId);
            }

            req.setAttribute("orderId", orderId);
            req.setAttribute("cartItems", cart);
            req.setAttribute("totalAmount", total);
            req.setAttribute("address", fullAddress);
            req.setAttribute("paymentType", paymentType);

            req.getRequestDispatcher("orderSuccess.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Order failed.");
            req.getRequestDispatcher("cart.jsp").forward(req, res);
        }
    }
}
