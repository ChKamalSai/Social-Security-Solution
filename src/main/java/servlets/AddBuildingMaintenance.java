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
import java.sql.SQLException;
import java.util.Properties;

@WebServlet("/addBuildingMaintenance")
public class AddBuildingMaintenance extends HttpServlet {
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
			String BuildingName=request.getParameter("BuildingName");
			int amount=Integer.parseInt(request.getParameter("Amount"));
			PreparedStatement prp1=con.prepareStatement("select * from Resident_Details where BuildingName=?");
			prp1.setString(1, BuildingName);
			ResultSet rs=prp1.executeQuery();
			try {
				con.setAutoCommit(false);
				while(rs.next()) {
					PreparedStatement prp=con.prepareStatement("Insert into Maintenance_Details(FlatNo,BuildingName,Amount) values(?,?,?)");
					prp.setInt(1,Integer.parseInt(rs.getString(3)));
					prp.setString(2, BuildingName);
					prp.setInt(3, amount);
					prp.executeUpdate();
				}
				con.commit();
				response.sendRedirect("SupervisorHomePage.jsp");
				
			}catch(SQLException e) {
				con.rollback();
				e.printStackTrace();
				response.sendRedirect("AddMaintenanceSupervisor.jsp");
				
			}
			
			
		}catch(Exception ex){
			ex.printStackTrace();
			response.sendRedirect("AddMaintenanceSupervisor.jsp");
			}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}