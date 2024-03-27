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

@WebServlet("/checkedOutRegular")
public class CheckedOutRegularVisitor extends HttpServlet {
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
			int SecurityCode=Integer.parseInt(request.getParameter("SecurityCode"));
			//int FlatNo=Integer.parseInt(request.getParameter("FlatNo"));
			String CheckIn=request.getParameter("CheckIn");
			PreparedStatement prp=con.prepareStatement("Update RegularVisitorTimings set CheckOut=? where SecurityCode=? and CheckIn=?");
			SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String CheckOut=formatter.format(new Date());
			prp.setString(1, CheckOut);
			prp.setInt(2, SecurityCode);
			prp.setString(3, CheckIn);
			prp.executeUpdate();
			PrintWriter out=response.getWriter();
//			out.println("<script>alert('Succesfully Deleted')</script>");
			response.sendRedirect("DisplayRegularVisitor.jsp");
		}catch(Exception ex){
			ex.printStackTrace();
			response.sendRedirect("DisplayRegularVisitor.jsp");}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
