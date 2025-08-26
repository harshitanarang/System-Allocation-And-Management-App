

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
 * Servlet implementation class AllocateServlet
 */
@WebServlet("/AllocateServlet")
public class AllocateServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String employeeName=request.getParameter("employeeName");		
		String designation=request.getParameter("designation");
		String systemNumber=request.getParameter("systemNumber");
		String ram=request.getParameter("ram");	
		String processor=request.getParameter("processor");
		//multiple accesories
	    String[] accessoriesArr=request.getParameterValues("accessories");
	    
	    String accessories="";
	    if (accessoriesArr != null) {
            accessories = String.join(",", accessoriesArr);
        }
		
		try {
			 Class.forName("com.mysql.cj.jdbc.Driver");
			 Connection con = DriverManager.getConnection(DBConfig.getUrl(), DBConfig.getUser(), DBConfig.getPass());
             String query="INSERT into employee_allocation(employee_name, designation, system_number, ram, processor, accessories) VALUES(?,?,?,?,?,?)";
			 PreparedStatement pstm=con.prepareStatement(query);
			 
			 pstm.setString(1, employeeName);
			 pstm.setString(2, designation);
			 pstm.setString(3, systemNumber);
			 pstm.setString(4, ram);
			 pstm.setString(5, processor);
			 pstm.setString(6,accessories );
			 
			 int i = pstm.executeUpdate();
			 if(i>0) {
				  out.println("<h2>Employee allocation saved successfully!</h2>");
				  response.sendRedirect("adminHome.jsp");
			 }
			 else {
				 out.println("<h2>Error while saving allocation.</h2>");
	            }
			 
			 con.close();
			 
		}catch(Exception e) {
			e.printStackTrace();
            out.println("Exception: " + e.getMessage());
		}
	}

}
