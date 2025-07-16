package servlet;

import dao.UserDao;
import daoImp.UserDaoImp;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.User;

import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserDao dao;

    @Override
    public void init() throws ServletException {
        dao = new UserDaoImp();
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(req, res);
        } else if ("register".equals(action)) {
            handleRegister(req, res);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(req, res);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = dao.login(email, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());

            if ("admin".equals(user.getRole())) {
                res.sendRedirect("adminProducts"); // redirect to AdminProductServlet
            } else {
                res.sendRedirect("products"); // redirect to customer products
            }
        } else {
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("signIn.jsp").forward(req, res);
        }
    }


    private void handleRegister(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        boolean success = dao.registerUser(user);
        if (success) {
        	res.sendRedirect("products");
        } else {
            req.setAttribute("error", "Registration failed");
            req.getRequestDispatcher("signIn.jsp").forward(req, res);
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate(); // clear session
        }
        res.sendRedirect("products");
    }
}
