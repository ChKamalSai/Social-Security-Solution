package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Properties;

@WebServlet("/clearMaintenanceSupervisor")
public class ClearMaintenanceResident extends HttpServlet {
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
			String date=request.getParameter("IssueDate");
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dateFormat=format.parse(date);
			Timestamp IssueDate=new Timestamp(dateFormat.getTime());
			Date newDate=new Date();
			String currentDate=format.format(newDate);
			
			int FlatNo=Integer.parseInt(request.getParameter("FlatNo"));
			String BuildingName=request.getParameter("BuildingName");
			PreparedStatement prp=con.prepareStatement("Update Maintenance_Details set PaymentStatus='paid' , ModeOfPayment='offline',Payment=? where BuildingName=? and FlatNo=? and IssueDate=? ");
			prp.setString(1, currentDate);
			prp.setString(2, BuildingName);
			prp.setInt(3, FlatNo);
			prp.setString(4,date);
			prp.executeUpdate();
			System.out.println(currentDate);
			PrintWriter out=response.getWriter();
			out.println("<script>alert('Succesfully Updated')</script>");
			response.sendRedirect("DisplayMaintenanceSupervisor.jsp");
		}catch(Exception ex){
			ex.printStackTrace();
			response.sendRedirect("DisplayMaintenanceSupervisor.jsp");
			}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
