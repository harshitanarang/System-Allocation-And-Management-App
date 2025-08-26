import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.PreparedStatement; 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession;

@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(false);
		
		if (session == null || session.getAttribute("employeeId") == null) {
			out.println("<h3>Please login first!</h3>"); return; 
		}
		
		int employeeId = (int) session.getAttribute("employeeId"); // taken from session at login 
		String employeeName = (String) session.getAttribute("employeeName"); // store at login time
        String systemNumber = request.getParameter("systemNumber");
        String problemType = request.getParameter("problemType");
        String description = request.getParameter("description");
        String urgency = request.getParameter("urgency");


		try { 
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection(DBConfig.getUrl(), DBConfig.getUser(), DBConfig.getPass());

		   String sql = "INSERT INTO complaints (employee_id, system_number, problem_type, description, urgency) VALUES (?, ?, ?, ?, ?)";
			
			PreparedStatement ps = con.prepareStatement(sql); 
			 ps.setInt(1, employeeId);
	         ps.setString(2, systemNumber);
	         ps.setString(3, problemType);
	         ps.setString(4, description);
	         ps.setString(5, urgency);
		
			
			int rows = ps.executeUpdate();
			con.close();
			
			if (rows > 0) { 
				out.println("<h3>Complaint submitted successfully!</h3>");
				out.println("<a href='employee.jsp'>Go Back</a>");
			}
			
			else { out.println("<h3>Failed to submit complaint.</h3>"); }
		}catch (Exception e) { 
			e.printStackTrace(); out.println("<h3>Error: " + e.getMessage() + "</h3>");
			}
	}
}
