<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ez-Buy Order Processing</title>
</head>
<BODY >

<h1 align="left"><font color="black" face="cursive">&nbsp; &nbsp; &nbsp; &nbsp;Ez-Buy</font></h1>

<%
// Get customer id
String custId = request.getParameter("customerId");
// Get password
String password = request.getParameter("password");
// Get shopping cart
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
                
try 
{	
	if (custId == null || custId.equals(""))
		out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
	else if (productList == null)
		out.println("<h1>Your shopping cart is empty!</h1>");
	else
	{	
		// Check if customer id is a number
		String userid = request.getParameter("customerId");  
        
		// Get database connection
        getConnection();
	                		
        String sql = "SELECT userID, firstName, pswd, cAddress FROM Customer WHERE userID = ?";	
				      
   		con = DriverManager.getConnection(url, uid, pw);
   		PreparedStatement pstmt = con.prepareStatement(sql);
   		pstmt.setString(1, userid);
   		ResultSet rst = pstmt.executeQuery();
   		int orderId=0;
   		String custName = "";

   		if (!rst.next())
   		{
   			out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
   		}
   		else
   		{	
   			custName = rst.getString(2);
			String dbpassword = rst.getString(3);
		    String add = rst.getString(4);
			// make sure the password on the database is the same as the one the user entered
			if (!dbpassword.equals(password)) 
			{
				out.println("The password you entered was not correct.  Please go back and try again.<br>"); 
				return;
			}
		
   			// Enter order information into database
   			sql = "INSERT INTO Orders (userID, totalAmount) VALUES(?, 0);";

   			// Retrieve auto-generated key for orderId
   			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
   	   		pstmt.setString(1, userid);

   			pstmt.executeUpdate();
   			ResultSet keys = pstmt.getGeneratedKeys();
   			keys.next();
   			orderId = keys.getInt(1);

   			out.println("<h1>Your Order Summary</h1>");
         	  	out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

           	double total =0;
           	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
           	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
						
           	while (iterator.hasNext())
           	{ 
           		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                   ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
   				String productId = (String) product.get(0);
                   out.print("<tr><td>"+productId+"</td>");
                   out.print("<td>"+product.get(1)+"</td>");
   				out.print("<td align=\"center\">"+product.get(3)+"</td>");
                   String price = (String) product.get(2);
                   double pr = Double.parseDouble(price);
                   int qty = ( (Integer)product.get(3)).intValue();
   				out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
                  	out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
                   out.println("</tr>");
                   total = total +pr*qty;

   				sql = "INSERT INTO OrderedProduct VALUES(?, ?, ?, ?)";
   				pstmt = con.prepareStatement(sql);
   				pstmt.setInt(1, orderId);
   				pstmt.setInt(2, Integer.parseInt(productId));
   				pstmt.setInt(3, qty);
   				pstmt.setString(4, price);
   				pstmt.executeUpdate();
   				
   				sql = "UPDATE Warehouse SET amount = amount - " + qty+ "WHERE productId = '" + Integer.parseInt(productId) +"'";
   				pstmt = con.prepareStatement(sql);
   				pstmt.executeUpdate();
   				
           	}
           	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                          	+"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
           	out.println("</table>");

   			// Update order total
   			sql = "UPDATE Orders SET totalAmount=? WHERE orderId=?";
   			pstmt = con.prepareStatement(sql);
   			pstmt.setDouble(1, total);
   			pstmt.setInt(2, orderId);			
   			pstmt.executeUpdate();						

   			out.println("<h1>Order completed.<br>On its way to be shipped.</h1>");
   			out.println("<h1>Your order reference number is: "+orderId+"</h1>");
   			out.println("<h1>Shipping to "+custName+" at "+add+ "</h1> ");

   			// Clear session variables (cart)
   			session.setAttribute("productList", null);    
   		}
   	}
}
catch (SQLException ex)
{ 	out.println(ex);
}
finally
{
	try
	{
		if (con != null)
			con.close();
	}
	catch (SQLException ex)
	{       out.println(ex);
	}
}  
%>                       				

<h2><a href="index.html">Return Home</a></h2>

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
