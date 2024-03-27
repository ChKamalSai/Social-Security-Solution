<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display CheckIn details Regular Visitor</title>
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
          	margin-right:80px;
            margin-top: 25px;
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
		.searchbar{
		margin-left:20px;
		margin-top:20px;
		padding:10px;
		/*border:2px solid #3CAF50;*/
		border-radius:5px;
		width:100%;
		font-size:18px;
		
		}
		.container{
        display:flex;}
        
        label {
    color: #000000; 
    font-size: 25px;
    display: block;
}

input {
    width: 30%;
    padding: 10px;
    border: 1px solid #800000;
    border-radius: 4px;
    font-size: 20px;
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
   <div class="container">
<div class="searchbar">
<input type="text" id="searchInput" placeholder="Search for Flat Number" oninput="searchItems()">
</div>
<div class="dropdown">
	<img  src="UserLogo.jpeg" alt="Logo" width="50" height="50" >
	<div class="dropdown-content">
	<a href="#"><%=session.getAttribute("UserName") %></a>
	<a href="sessionlogout">Logout</a>
	</div>
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
			PreparedStatement prp=con.prepareStatement("select * from RegularVisitorTimings order by CheckOut is Null , CheckOut Desc ");
			ResultSet rs=prp.executeQuery();
			%>
			<table>
				<tr>
					<th>SecurityCode</th>
					<th>Flat Number</th>
					<th>Building Name</th>
					<th>CheckIn Time</th>
					<th>CheckOut Time</th>
					<th>CheckedOut Button</th>
				<tr>
			<%
			while(rs.next()){
				int SecurityCode=rs.getInt(1);
				int FlatNo=rs.getInt(2);
				String BuildingName=rs.getString(3);
				String CheckIn=rs.getString(4);
				String CheckOut=rs.getString(5);
				%>
				<tr>
					<td><%=SecurityCode%></td>
					<td><%=FlatNo%></td>
					<td><%=BuildingName%></td>
					<td><%=CheckIn%></td>
					<td><%=CheckOut%></td>
					<%
					if(CheckOut==null&&CheckIn!=null){
						%>
					<td>
					<form action="checkedOutRegular" method="post">
						<input type="hidden" value="<%=SecurityCode%>" name="SecurityCode">
						<input type="hidden" value="<%=CheckIn%>" name="CheckIn">
						<button type="Submit">CheckedOut</button>
					</form>
						</td>
						<%
					}
					%>
				</tr>
	
				<%
			}
			%>
			</table>

			<%
		}catch(SQLException ex) {
			ex.printStackTrace();
		} }%>
&nbsp&nbsp&nbsp <button onclick="window.location.href='SupervisorHomePage.jsp'">Go Back</button>
<script>
function searchItems() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchInput");
    filter = input.value.toLowerCase();
    table = document.querySelector("table");
    tr = table.getElementsByTagName("tr");

    for (i = 1; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[1]; 
        if (td) {
            txtValue = td.textContent|| td.innerText;
            txt=txtValue.toLowerCase();
            if (txt.includes(filter) ) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}
</script>
</body>
</html>