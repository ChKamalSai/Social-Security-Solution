<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginPage</title>
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
}

h1 {
    font-size: 50px;
    margin: 0;
    color: #fff;
    }

p {
    color: #666; 
    font-size: 18px;
}

/* .container {
    background-color: rgba(201, 197, 197, 0.9);
} */

.login-form {
    /* background-color: #fff;
    border: 2px solid rgb(0,0,0) ;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
    border-radius:10px; */
    padding: 20px;
    margin-left: 30%;
    margin-right:30%;
    margin-top: 1%;
    text-align: center;
    /* max-width: 30%; */
}

h2 {
    /* color: #800000;  */
    font-size: 40px;
    margin-bottom: 20px;
}

/* form {
    display: flex;
    flex-direction: column;
} */

.input-box {
    margin-bottom: 20px;
    text-align: left;
}

label {
    color: #000000; 
    font-size: 25px;
    display: block;
}

input {
    width: 95%;
    padding: 10px;
    border: 1px solid #800000;
    border-radius: 4px;
    font-size: 25px;
    outline: none;
    color: #0d0c0c;
    background-color: #fff;
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
        <!-- <p>Your Trusted Social Security Solutions Provider</p> -->
    </div>
    <!-- <div class="container"> -->

        <div class="login-form">
            <h2>Login</h2>
            <div class="input-box">
            <form onsubmit="return validateForm()" action="" method="post">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                    <br><br>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                    <br><br>
                    <button type="submit">Login</button>
                </form>
            </div>
        <!-- </div> -->
    </div>
    <script>
		function validateForm(){
			var x=document.forms[0];
			if(x[0].value.trim()===""){
				alert("UserName cannot be empty");
				return false;
			}
			if(x[1].value.trim()===""){
				alert("Password cannot be empty");
				return false;
			}
			return true;
					};
		</script>
		<% 
			String username=request.getParameter("username");
		if(username!=null){
		Properties prop=getConnectionData();
		String url=prop.getProperty("db.url");
		String user=prop.getProperty("db.user");
		String paswd=prop.getProperty("db.passwd");
		Class.forName("com.mysql.jdbc.Driver");
		try(Connection con=DriverManager.getConnection(url,user,paswd)){
			String password=request.getParameter("password");
			PreparedStatement prp =con.prepareStatement("select * from Login_Credentials where UserName=?") ;
			prp.setString(1, username);
			ResultSet rs=prp.executeQuery();
			if(rs.next()){
				if(rs.getString(2).equals(password)){
					session.setAttribute("UserName",username);
					if(rs.getString(3).equals("Admin")){
						response.sendRedirect("AdminHomePage.jsp");
					}
					else if(rs.getString(3).equals("Supervisor")){
						response.sendRedirect("SupervisorHomePage.jsp");						
					}
					else if(rs.getString(3).equals("Resident")){
						response.sendRedirect("ResidentsHomePage.jsp");
					}
				}
				else{
					out.println("<script>alert('Incorrect Password')</script>");
				}
			}
			else{
				out.println("<script>alert('User Name does not exist ')</script>");
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		} }%>
</body>
</html>