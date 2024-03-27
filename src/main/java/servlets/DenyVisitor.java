package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

@WebServlet("/denyVisitor")
public class DenyVisitor extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Properties getConnectionData() {

	    Properties props = new Properties();

	    //String fileName = "src/main/resources/db.properties";
	    String fileName = "/home/kamal/eclipse-workspace/SSS/src/main/webapp/db.properties";

	    try (FileInputStream in = new FileInputStream(fileName)) {
	        props.load(in);
	    } catch (IOException ex) {
	       // Logger lgr = Logger.getLogger(Q7.class.getName());
	        //lgr.log(Level.SEVERE, ex.getMessage(), ex);
	    	ex.printStackTrace();
	    }

	    return props;
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Properties prop=getConnectionData();
		String url=prop.getProperty("db.url");
		String user=prop.getProperty("db.user");
		String paswd=prop.getProperty("db.passwd");
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try(Connection con=DriverManager.getConnection(url,user,paswd)){
			int VisitorID=Integer.parseInt(request.getParameter("VisitorId"));
			PreparedStatement prp=con.prepareStatement("Update NormalVisitor_Details set RequestStatus='Denied' where VisitorID=?");
			prp.setInt(1, VisitorID);	
			prp.executeUpdate();
			PrintWriter out=response.getWriter();
//			out.println("<script>alert('Succesfully Deleted')</script>");
			response.sendRedirect("ResidentsHomePage.jsp");
		}catch(Exception ex){
			ex.printStackTrace();
			response.sendRedirect("ResidentsHomePage.jsp");}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
