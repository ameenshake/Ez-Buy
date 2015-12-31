<%@page import="com.mysql.jdbc.PreparedStatement"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*"%>
<HTML>
<HEAD>
<TITLE>Your Shopping Cart</TITLE>
</HEAD>
<BODY" >

<h1 align="left"><font color="black" face="cursive">&nbsp; &nbsp; &nbsp; &nbsp;Ez-Buy</font></h1>

<hr />
<script>
function update(newid, newqty)
{
	window.location="showcart.jsp?update="+newid+"&newqty="+newqty;
}
</script>
<FORM name="form1">

<%
// Get the current list of products
HashMap productList = (HashMap) session.getAttribute("productList");
ArrayList product = new ArrayList();
String id = request.getParameter("delete");
String update = request.getParameter("update");
String newqty = request.getParameter("newqty");

// check if shopping cart is empty
if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap();
}
else
{
	try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	} catch (ClassNotFoundException ce) {
		System.err.println(ce);
	}
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jbutler;";
	String uid = "jbutler";
	String pw = "41498130";
	Connection con = DriverManager.getConnection(url, uid, pw); 
	
	
	
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	// if id not null, then user is trying to remove that item from the shopping cart
	if(id != null && (!id.equals(""))) {
		if(productList.containsKey(id)) {
			productList.remove(id);
		}
	}
	
	// if update isn't null, the user is trying to update the quantity
	if(update != null && (!update.equals(""))) {
		if (productList.containsKey(update)) { // find item in shopping cart
			product = (ArrayList) productList.get(update);
			product.set(3, (new Integer(newqty))); // change quantity to new quantity
		}
		else {
			productList.put(id,product);
		}
	}

	// print out HTML to print out the shopping cart
	out.println("<H1>Your Shopping Cart</H1>");
	out.print("<font face=\"Century Gothic\" size=\"2\"><TABLE border = 1 style=\"background-color:white\"><TR><TH>Product Id</TH><TH>Product Name</TH><TH>Quantity</TH>");
	out.println("<TH>Price</TH><TH>Subtotal</TH><TH></TH><TH></TH><TH>In Stock?</TH></TR>");

	int count = 0;
	double total =0;
	// iterate through all items in the shopping cart
	Iterator iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) {
		count++;
		Map.Entry entry = (Map.Entry)(iterator.next());
		product = (ArrayList) entry.getValue();
		// read in values for that product ID
		out.print("<TR><TD>"+product.get(0)+"</TD>");
		out.print("<TD>"+product.get(1)+"</TD>");

		out.print("<TD ALIGN=CENTER><INPUT TYPE=\"text\" name=\"newqty"+count+"\" size=\"3\" value=\""
			+product.get(3)+"\"></TD>");
		double pr = Double.parseDouble( (String) product.get(2));
		int qty = ( (Integer)product.get(3)).intValue();
		
		// print out values for that product from shopping cart
		out.print("<TD ALIGN=RIGHT>"+currFormat.format(pr)+"</TD>");
		out.print("<TD ALIGN=RIGHT>"+currFormat.format(pr*qty)+"</TD>");
		// allow the customer to delete items from their shopping cart by clicking here
		out.println("<TD>&nbsp;&nbsp;&nbsp;&nbsp;<A HREF=\"showcart.jsp?delete="
			+product.get(0)+"\">Delete Item</A></TD>");
		// allow customer to change quantities for a product in their shopping cart
		out.println("<TD>&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE=BUTTON OnClick=\"update("
			+product.get(0)+", document.form1.newqty"+count+".value)\" VALUE=\"Update Quantity\">");
		String sql = "SELECT * FROM Warehouse Where productId = '" + product.get(0) + "' AND amount >= " +product.get(3) ;
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql);
		if(rst.next()){
			out.println("<td>Yes</td>");
		}
		else{
		out.println("<td>No</td>");}
		out.println("</TR>");
		// keep a running total for all items ordered
		total = total +pr*qty;
	}
	// print out order total
	out.println("<TR><TD COLSPAN=4 ALIGN=RIGHT><B>Order Total</B></TD>"
			+"<TD ALIGN=RIGHT>"+currFormat.format(total)+"</TD></TR>");
		
		
	
	
				
	out.println("</TABLE>");
	//give user option to check out
	out.println("<H2><A HREF=\"checkout.jsp\">Check Out</A></H2>");
}
// set the shopping cart
session.setAttribute("productList", productList);
// give the customer the option to add more items to their shopping cart
%>
<H2><A HREF="listprod.jsp">Continue Shopping</A></H2>
</FORM>
</BODY>
</HTML> 

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



