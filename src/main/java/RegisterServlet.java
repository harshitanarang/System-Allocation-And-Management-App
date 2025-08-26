

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

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		
		PrintWriter out=response.getWriter();
		
		String username=request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role"); // admin / employee
	    String designation = request.getParameter("designation");
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");

	    	   Connection con = DriverManager.getConnection(DBConfig.getUrl(), DBConfig.getUser(), DBConfig.getPass());

	    	   
	    	   String query=  "INSERT INTO users(username, password, role, designation) VALUES (?,?,?,?)";
	    	   PreparedStatement pstm=con.prepareStatement(query);
	    	   
	    	   pstm.setString(1, username);
	    	   pstm.setString(2, password);
	    	   pstm.setString(3, role);
	    	   pstm.setString(4, designation);
	    	   
	    	   int result = pstm.executeUpdate();
	    	   
	    	   if(result>0) {
	    		   response.sendRedirect("successfull.html");
	         
	    	   }
	    	   
	    	   else {
	    		   response.sendRedirect("unsucess.html");
	    		   
	    	   }
	    	   
	    	   con.close();
	    	
	    }catch(Exception e) {
	    	e.printStackTrace(out);
	    }
	 

		
		
	}

}
