<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resident Home Page</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
#visitor{
display:block;}
#para {
  font-size: 24px;
  color: #800000; 
  cursor: pointer; 
  display: flex; 
  justify-content: space-between;
  align-items: center; 
  padding: 10px; 
}

#para i {
  font-size: 20px; 
  margin-left: 10px; 
}

#para:hover {
  background-color: #f2f2f2; 
}
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
		.box{
    	margin-top:2.5%;
    	margin-bottom:5%;
    	}
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
			align-items:center;
            min-height: 20vh;
         
        }
        .option {
            flex: 0 0 calc(33.33% - 50px);
            margin: 20px;
            padding: 50px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            /* transition: transform 0.2s; */
        }
        .option:hover {
            transform: scale(1.05);
        }
        .option a {
            text-decoration: none;
            color: #800000;
            font-size: 24px;
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
table {
  width: 98%;
  border-collapse: collapse;
  border-spacing: 0;
  margin: 20px 0 10px 10px;
  font-size:20px;
}

th {
  background-color: #333;
  color: #fff;
  text-align: left;
  padding: 10px;
  border: 1px solid #ddd;
}

td {
  padding: 8px;
  border: 1px solid #ddd;
}
tr:nth-child(even) {
  background-color: #f2f2f2;
}

tr:hover {
  background-color: #ccc;
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
	<a  href="ResidentProfilePage.jsp">Profile</a>
	<a  href="sessionlogout">Logout</a>
</div>
</div>	
<p id="para">Pending Visitor Requests<i class="fas fa-chevron-up"></i></p>
<div id="visitor"><% 
			String username=(String)session.getAttribute("UserName");
				if(username!=null){
		Properties prop=getConnectionData();
		String url=prop.getProperty("db.url");
		String user=prop.getProperty("db.user");
		String paswd=prop.getProperty("db.passwd");
		Class.forName("com.mysql.jdbc.Driver");
		try(Connection con=DriverManager.getConnection(url,user,paswd)){
			PreparedStatement prp1=con.prepareStatement("select * from Resident_Details where UserName=?");
			prp1.setString(1,username);
			ResultSet rs1=prp1.executeQuery();
			int FlatNo=0;
			String BuildingName="";
			if(rs1.next()){
				
			FlatNo=rs1.getInt(3);
			BuildingName=rs1.getString(4);
			}
			PreparedStatement prp=con.prepareStatement("select * from NormalVisitor_Details where FlatNo=? and BuildingName=? and RequestStatus='Pending'");
			prp.setInt(1,FlatNo);
			prp.setString(2,BuildingName);
			ResultSet rs=prp.executeQuery();
			%>
			<table>
				<tr>
					<th>Name</th>
					<th>Mobile</th>
					<th>Status</th>
					<th>Approve Button</th>
					<th>Deny Button</th>
				<tr>
			<%
			while(rs.next()){
				int VisitorID=rs.getInt(1);
				String Name=rs.getString(2);
				int Mobile=rs.getInt(3);
				String Status=rs.getString(9);
				%>
				<tr>
					<td><%=Name%></td>
					<td><%=Mobile%></td>
					<td><%=Status%></td>
					<td>
					<form action="approveVisitor" method="post">
						<input type="hidden" value="<%=VisitorID%>" name="VisitorId">
					<button type="Submit">Approve</button>
						</form>
					</td>
					<td>
					<form action="denyVisitor" method="post">
						<input type="hidden" value="<%=VisitorID%>" name="VisitorId">
						<button type="Submit">Deny</button>
						</form>
						</td>
				</tr>
	
				<%
			}
			%>
			</table>

			<%
		}catch(SQLException ex) {
			ex.printStackTrace();
		} }%>
		
		</div>
<div class="box">
    <div class="container">
        <div class="option">
            <a href="ResidentMaintenanceDetails.jsp">Display Maintenance Details</a>
        </div>
        <div class="option">
            <a href="ResidentRegularVisitor.jsp"> Display Regular Visitor Details</a>
        </div>
    </div>
</div>
<script>
document.getElementById('para').addEventListener('click', function() {
	  var form = document.getElementById('visitor');
	  var icon = document.querySelector('#para i');
	  if (form.style.display === 'none' || form.style.display === '') {
	    form.style.display = 'block';
	    icon.classList.remove('fa-chevron-down');
	    icon.classList.add('fa-chevron-up');
	  } else {
	    form.style.display = 'none';
	    icon.classList.remove('fa-chevron-up');
	    icon.classList.add('fa-chevron-down');
	  }
	  
	});</script> 
</body>
</html>