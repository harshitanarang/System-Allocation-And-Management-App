import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RootServlet")
public class RootServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(DBConfig.getUrl(), DBConfig.getUser(), DBConfig.getPass());

            // ✅ Check login with role
            ps = con.prepareStatement(
            	    "SELECT id, username, role, designation FROM users WHERE TRIM(username)=? AND TRIM(password)=? AND TRIM(role)=?");
            	ps.setString(1, username);
            	ps.setString(2, password);
            	ps.setString(3, request.getParameter("role"));  // role from login form

            rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                int userId = rs.getInt("id");
                String role = rs.getString("role");

                session.setAttribute("userId", userId);
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("role", role);
                session.setAttribute("designation", rs.getString("designation"));

                if ("admin".equalsIgnoreCase(role)) {
                    // 🔹 Redirect admin to admin page
                    response.sendRedirect("adminHome.jsp");
                } else if ("employee".equalsIgnoreCase(role)) {
                    // 🔹 Employee → check system allocation
                    ps2 = con.prepareStatement(
                        "SELECT system_number, ram, accessories " +
                        "FROM employee_allocation WHERE id=?");
                    ps2.setInt(1, userId);

                    rs2 = ps2.executeQuery();
                    if (rs2.next()) {
                        session.setAttribute("systemNumber", rs2.getString("system_number"));
                        session.setAttribute("ram", rs2.getString("ram"));
                        session.setAttribute("accessories", rs2.getString("accessories"));
                    } else {
                        session.setAttribute("systemNumber", "Not Allocated");
                        session.setAttribute("ram", "Not Allocated");
                        session.setAttribute("accessories", "Not Allocated");
                    }

                    // ✅ Redirect to employee dashboard
                    response.sendRedirect("employee.jsp");
                } else {
                    out.println("<h3>Unknown role. Please contact admin.</h3>");
                }

            } else {
                // 🔹 Account not found
            	response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs2 != null) rs2.close(); } catch (Exception e) {}
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps2 != null) ps2.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
