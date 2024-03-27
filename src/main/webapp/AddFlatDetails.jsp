<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Flat Details</title>
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

.dropdown{
            position: relative;
            margin-left: 90%; 
            /*margin-right: 10px; */
            margin-top: 10px;
            display: inline-block;
            background-color: #f2f2f2;
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
    padding:0 20px 20px 20px;
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
	margin-top:10%;
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
    </div>
   
<div class="dropdown">
	<img  src="UserLogo.jpeg" alt="Logo" width="50" height="50" >
	<div class="dropdown-content">
	<a href="#"><%=session.getAttribute("UserName") %></a>
	<a  href="sessionlogout">Logout</a>
	</div>
</div> 

<div class="login-form">
            <h2>Add Flat Details</h2>
            <div class="input-box">
            <form onsubmit="return validateForm()" action="" method="post">
                   	<label>Flat Number:</label>
                   	<input type="number" name="FlatNo" required><br><br>
                    <label >Building Name:</label>
                    <input type="text" name="BuildingName" pattern=".{1,30}" title ="max 30 characters"  required>
                    <br><br>
                   	<label>Flat Type:</label>
                   	<input type="text" name="FlatType" pattern=".{1,10}"  title ="max 10 characters" placeholder="Ex: 1BHK, 2BHK,..." required><br><br>
                    <button type="submit">Add</button>
                    <button type="reset">Reset</button><br><br>
                    <button onclick="window.location.href='AdminHomePage.jsp'">Go Back</button>
                </form>
            </div>
    </div>

<script>
function validateForm(){
	var x= document.forms[0];
	if(!/^[0-9]+$/.test(x[0].value)){
		alert("Flat number should be positive integer");
		return false;
	}
	if(x[1].value.trim()===""){
		alert("Building Name cannot be empty");
		return false;
	}
	if(x[2].value.trim()===""){
		alert("Flat Type cannot be empty");
		return false;
	}
	return true;
}
</script>
<% 
			String username=(String)session.getAttribute("UserName");
			String BuildingName=request.getParameter("BuildingName");
		if(username!=null &&BuildingName!=null){
		Properties prop=getConnectionData();
		String url=prop.getProperty("db.url");
		String user=prop.getProperty("db.user");
		String paswd=prop.getProperty("db.passwd");
		Class.forName("com.mysql.jdbc.Driver");
		try(Connection con=DriverManager.getConnection(url,user,paswd)){
			int FlatNo=Integer.parseInt(request.getParameter("FlatNo"));
			String FlatType=request.getParameter("FlatType");
			PreparedStatement prp =con.prepareStatement("select * from Flat_Details where FlatNo=? and BuildingName=?") ;
			prp.setInt(1,FlatNo);
			prp.setString(2, BuildingName);
			ResultSet rs=prp.executeQuery();
			if(!rs.next()){
				PreparedStatement prp4=con.prepareStatement("select * from Building_Details where BuildingName=?");
				prp4.setString(1,BuildingName);
				ResultSet rs4=prp4.executeQuery();
				if(rs4.next()){
					int floors=rs4.getInt(3);
					int flats=rs4.getInt(4);
					int a=floors*100+flats;
					int b=FlatNo%100;
					if(FlatNo<a &&b<flats ){
						
				PreparedStatement prp1=con.prepareStatement("insert into Flat_Details values(?,?,?)");
				prp1.setInt(1,FlatNo);
				prp1.setString(2,BuildingName);
				prp1.setString(3,FlatType);
				prp1.executeUpdate();
				out.println("<script>alert('Succesfully Added ')</script>");
				response.sendRedirect("AdminHomePage.jsp");
					}else{
						out.println("<script>alert('This flatNo doesnot exist ')</script>");
					}
				}else{
					out.println("<script>alert('BuildingName does not exist')</script>");
				}
			}
			else{
				out.println("<script>alert('This Flat number in this Building Name already exists ')</script>");
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		} }%>
</body>
</html>