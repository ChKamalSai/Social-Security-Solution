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
import java.util.Properties;

@WebServlet("/addFlatMaintenance")
public class AddFlatMaintenance extends HttpServlet {
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
			int FlatNo=Integer.parseInt(request.getParameter("FlatNo"));
			String BuildingName=request.getParameter("BuildingName");
			int amount=Integer.parseInt(request.getParameter("Amount"));
			PrintWriter out= response.getWriter();
			PreparedStatement prp1=con.prepareStatement("select * from Resident_Details where FlatNo=? and BuildingName=? ");
			prp1.setInt(1, FlatNo);
			prp1.setString(2, BuildingName);
			ResultSet rs=prp1.executeQuery();
			if(rs.next()) {
				PreparedStatement prp=con.prepareStatement("Insert into Maintenance_Details(FlatNo,BuildingName,Amount) values(?,?,?)");
				prp.setInt(1, FlatNo);
				prp.setString(2, BuildingName);
				prp.setInt(3, amount);
				prp.executeUpdate();
				response.sendRedirect("SupervisorHomePage.jsp");
			}else {
				out.println("<script>alert('There is no resident in this flat or Flatno and Building does not exist.Click OK to continue...');</script>");
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