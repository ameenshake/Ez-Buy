<html>
<head>
<title>Login</title>
</head>
<body  >

<h1>Enter your Username and Password to continue:</h1>


<form method="get" action="order.jsp">
            <center>
            <table border="1" width="30%" cellpadding="3">
                <thead>
                    <tr>
                        <th colspan="2">Login Here</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>UserName</td>
                        <td><input type="text" name="customerId" value="" required/></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="password" value="" required/></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Login" /></td>
                        <td><input type="reset" value="Reset" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"> Not Registered? <a href="signUp.html">Sign Up Here</a></td>
                    </tr>
                </tbody>
            </table>
            </center>
        </form>

</body>
</html>

<style>


.navbar {
    margin-bottom: 0;
    background-color: #1BA97E;
    z-index: 9999;
    border: 0;
    font-size: 12px !important;
    line-height: 1.42857143 !important;
    letter-spacing: 4px;
    border-radius: 0;
}

.navbar li a, .navbar .navbar-brand {
    color: black !important;
}

.navbar-nav li a:hover, .navbar-nav li.active a {
    color: #1BA97E!important;
    background-color: #fff !important;
}

.navbar-default .navbar-toggle {
    border-color: transparent;
    color: #fff !important;
    
}

footer .glyphicon {
    font-size: 20px;
    margin-bottom: 20px;
    color: #fff;
 }
form {
      width:300px;
      margin:10px auto;
}
.search {
         padding:8px 15px;
         background:rgba(50, 50, 50, 0.2);
         border:0px solid #dbdbdb;
         font-family: 'Fira Sans', sans-serif;
}
.button {
        position:relative;
        padding:6px 15px;
        left:-8px;
        border:2px solid #007350;
        background-color:#007350;
        color:#fafafa;
        font-family: 'Fira Sans', sans-serif;
}
.button:hover  {
       background-color:#fafafa;
       color:#007350;
}   

table{
	background-color:white;	
}
.tablefont{

}
</style>