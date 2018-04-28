<html>
<head>
<title>Register</title>
<link rel="stylesheet" href="index.css">
</head>
<body>  
 <div class="topnav">
	   <a class="active" href="index.html">Home</a>
	   <a href="form.html">Register</a>
	   <a href="login.html">Login</a>
 </div> 


<h2>Register Now!</h2>
	<form method = "post" action = "action_page.php">
		Name: <input type="text" name="name" maxlength="20" pattern="[A-Za-z ]+" required><br>
		E-mail: <input type="text" name="email" pattern = "[A-za-z]+@.+\.com" required><br>
		Mobile: <input type="text" name="mobile" pattern="[1-9][0-9]{9}"><br>
		Bank Account: <input type="text" name="account" pattern="[0-9]{5}"><br>
		Bank Account password: <input type="password" name="password" pattern="[0-9a-zA-Z]+" maxlength="20"><br>
		Address: <input type="text" name="address" maxlength = "100"><br>
		<input type="submit">
	</form>


</body>
</html>
