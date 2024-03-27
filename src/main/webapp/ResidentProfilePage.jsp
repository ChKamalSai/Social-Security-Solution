<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resident Home Page</title>
<style>
body {
    background-color: #fff; 
    font-family: Arial, sans-serif;
    margin: 0;
    justify-content: center;
    align-items: center;
    height: 100vh;
    color: #000000; 
}

.header {
    background-color: #800000; 
    padding: 30px;
    /* margin:2%; */
    border-radius: 10px 10px 10px 10px;
    margin-left: 2px;
    margin-right: 2px;
    text-align: center;
       color: #fff; 
}

h1 {
    font-size: 50px;
    margin: 0;
    color: #fff;
    }

.dropdown{
            position: relative;
            margin-left: 90%; 
            /*margin-right: 10px; */
            margin-top: 10px;
            display: inline-block;
            background-color: #fff;
        }

        .dropdown-content{
            display :none;
            position: absolute;
            background-color: #fff;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index:1;
        }
        .dropdown:hover .dropdown-content{
            display: block;
        }
        .dropdown-content a{
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            color: #333;
        }
        .dropdown-content a:hover{
            background-color: #f2f2f2;
        }
        a:hover{
			
			color:#800000;  
		}

.login-form {
    /* background-color: #fff;
    border: 2px solid rgb(0,0,0) ;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
    border-radius:10px; */
    margin-left: 30%;
    margin-right:30%;
    margin-top: 1%;
    text-align: center;
    font-size:25px;
    padding:0 20px 20px 20px;
    /* max-width: 30%; */
}
button {
    background-color: #800000; 
    color: #fff;
    border: none;
    border-radius: 4px;
    padding: 10px 20px;
    font-size: 25px;
    cursor: pointer;
    transition: background-color 0.3s;
}

button:hover {
    background-color: #8B0000; 
}
</style>

</head>
<body>
 <%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.logging.*" %>
<%@	page import="jakarta.servlet.*" %>
<%!private static Properties getConnectionData() {

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
} %>
<div class="header">
        <h1>Anarark Complex</h1>
</div>
<div class="dropdown">
	<img  src="UserLogo.jpeg" alt="Logo" width="50" height="50" >
	<div class="dropdown-content">
	<a href="#"><%=session.getAttribute("UserName") %></a>
	<a  href="sessionlogout">Logout</a>
	</div>
</div> 

<% 
			String username=(String)session.getAttribute("UserName");
				if(username!=null){
		Properties prop=getConnectionData();
		String url=prop.getProperty("db.url");
		String user=prop.getProperty("db.user");
		String paswd=prop.getProperty("db.passwd");
		Class.forName("com.mysql.jdbc.Driver");
		try(Connection con=DriverManager.getConnection(url,user,paswd)){
			PreparedStatement prp=con.prepareStatement("select * from Resident_Details where UserName=?");
			prp.setString(1,username);
			ResultSet rs=prp.executeQuery();
			if(rs.next()){
				String UserName=rs.getString(1);
				String Name=rs.getString(2);
				int FlatNo=rs.getInt(3);
				String BuildingName=rs.getString(4);
				int Mobile=rs.getInt(5);
				%>
				<div class="login-form">
				<p><b>Name:</b> &nbsp<%=Name %></p>
				<p><b>Flat Number:</b> &nbsp<%=FlatNo %></p>
				<p><b>Building Name:</b> &nbsp<%=BuildingName %></p>
				<p><b>Mobile:</b> &nbsp<%=Mobile %></p>
					<form action="UpdatePasswordResident.jsp" method="post">
						<input type="hidden" name="UserName" value=<%=UserName%>>
						<button type="submit">Update Password</button>
					</form>	
				</div>
		
				<%
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		} }%>


&nbsp&nbsp&nbsp <button onclick="window.location.href='ResidentsHomePage.jsp'">Go Back</button>

</body>
</html>