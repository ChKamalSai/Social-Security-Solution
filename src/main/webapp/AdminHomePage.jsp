<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Home Page</title>
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
        


</style>
</head>
<body>
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
<div class="box">
    <div class="container">
        <div class="option">
            <a href="AddBuildingDetails.jsp">Add Building Details</a>
        </div>
        <div class="option">
            <a href="ShowBuildingDetails.jsp">Display Building Details</a>
        </div>
    </div>
    <div class="container">
        <div class="option">
            <a href="AddFlatDetails.jsp">Add Flat Details</a>
        </div>
        <div class="option">
            <a href="ShowFlatDetails.jsp">Display Flat Details</a>
        </div>
    </div>
    <div class="container">
        <div class="option">
            <a href="AddResidentDetails.jsp">Add Resident Details</a>
        </div>
        <div class="option">
            <a href="ShowResidentDetails.jsp">Display Resident Details</a>
        </div>
    </div>
</div>	
</body>
</html>