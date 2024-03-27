<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Maintenance Amount By Supervisor</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
 #myForm {
         display: none;
        }
        #myForm1{
         display: none;
        }
        #id,#id1 {
  font-size: 24px;
  color: #800000; 
  cursor: pointer; 
  display: flex; 
  justify-content: space-between;
  align-items: center; 
  padding: 10px; 
}

#id i,#id1 i {
  font-size: 20px; 
  margin-left: 10px; 
}

#id:hover,#id1:hover {
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

            <p id="id">For all Flats of Building  <i class="fas fa-chevron-down"></i></p>
<div class="login-form">
            
            <div class="input-box">
            <form id="myForm"onsubmit="return validateForm()" action="addBuildingMaintenance" method="post">
                    <label>Building Name:</label>
                    <input type="text" name="BuildingName" pattern=".{1,30}" title ="max 30 characters"  required><br><br>
                   	<label>Amount:</label>
                   	<input type="number" name="Amount" required><br><br>
                    <br><br>
                   	<button type="submit">Add</button>
                    <button type="reset">Reset</button>
                    </form>
            </div>
    </div>

            <p id="id1">For selected Flat of Building  <i class="fas fa-chevron-down"></i> </p>
<div class="login-form">
            <div class="input-box">
            <form id="myForm1" onsubmit="return validate()" action="addFlatMaintenance" method="post">
                   	<label>Flat Number:</label>
                   	<input type="number" name="FlatNo" required><br><br>
                    <label >Building Name:</label>
                    <input type="text" name="BuildingName" pattern=".{1,30}" title ="max 30 characters"  required><br><br>
                    <label>Amount:</label>
                   	<input type="number" name="Amount" required><br><br>
                    <br><br>
                   	<button type="submit">Add</button>
                    <button type="reset">Reset</button><br><br>
                </form>
            </div>
    </div>
    

&nbsp&nbsp&nbsp&nbsp  <button onclick="window.location.href='SupervisorHomePage.jsp'">Go Back</button>
<script>
document.getElementById('id').addEventListener('click', function() {
	  var form = document.getElementById('myForm');
	  var icon = document.querySelector('#id i');
	  if (form.style.display === 'none' || form.style.display === '') {
	    form.style.display = 'block';
	    icon.classList.remove('fa-chevron-down');
	    icon.classList.add('fa-chevron-up');
	  } else {
	    form.style.display = 'none';
	    icon.classList.remove('fa-chevron-up');
	    icon.classList.add('fa-chevron-down');
	  }
	  
	});
document.getElementById('id1').addEventListener('click', function() {
	  var form = document.getElementById('myForm1');
	  var icon = document.querySelector('#id1 i');
	  if (form.style.display === 'none' || form.style.display === '') {
	    form.style.display = 'block';
	    icon.classList.remove('fa-chevron-down');
	    icon.classList.add('fa-chevron-up');
	  } else {
	    form.style.display = 'none';
	    icon.classList.remove('fa-chevron-up');
	    icon.classList.add('fa-chevron-down');
	  }
	  
	});
function validateForm(){
	var x= document.forms[0];
	if(x[0].value.trim()===""){
		alert("Building Name cannot be empty");
		return false;
	}
	if(!/^[0-9]+$/.test(x[1].value)){
		alert("Amount should be positive integer");
		return false;
	}
	return true;
}
function validate(){
	var x= document.forms[1];
	if(!/^[0-9]+$/.test(x[0].value)){
		alert("Flat number should be positive integer");
		return false;
	}
	if(x[1].value.trim()===""){
		alert("Building Name cannot be empty");
		return false;
	}
	if(!/^[0-9]+$/.test(x[2].value)){
		alert("Amount should be positive integer");
		return false;
	}
	return true;
}
</script>

</body>
</html>