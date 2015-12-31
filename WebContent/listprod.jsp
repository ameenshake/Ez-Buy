<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.HashMap"%>
<!DOCTYPE html>
<html lang="en">

<head>
 <title>Catalog</title>
<link href='https://fonts.googleapis.com/css?family=Fira+Sans:400,500' rel='stylesheet' type='text/css'>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>
<body>

<!--NAVIGATION BAR--> 
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      
      <a class="navbar-brand" href="#">EZ Buy</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
      	<li>
                  <form method="get" action="listprod.jsp">
		<p align="left">
		<p>Categories:</p>
			<select size="1" name="categoryName">
				<option>All</option>
				<%
					Connection con = null;
					try {
							Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
						} catch (ClassNotFoundException ce) {
							System.err.println(ce);
						}

					// Could create category list dynamically - more adaptable, but a little more costly
					try {
						
						con = DriverManager.getConnection("jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jbutler", "jbutler", "41498130");
						ResultSet rst = con.createStatement().executeQuery("SELECT DISTINCT categoryName FROM Product");
						while (rst.next())
							out.println("<option>" + rst.getString(1) + "</option>");
					} catch (SQLException ex) {
						out.println(ex);
					}
				%>



				<input class = "search"type="text" name="productName" size="50">
			</select><input class ="button"type="submit" value="Submit"><input class ="button" type="reset"
				value="Reset">
		</p>
	</form>
<div style="height:800px; overflow:auto">
	<%
		HashMap colors = new HashMap(); // This may be done dynamically as well, a little tricky...
		colors.put("Toys", "#0000FF");
		colors.put("Home Essentials", "#FF0000");
		colors.put("Beauty", "#000000");
		colors.put("Clothing", "#6600CC");
		
		// Get product name to search for
		String name = request.getParameter("productName");
		String category = request.getParameter("categoryName");
		boolean hasNameParam = name != null && !name.equals("");
		boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
		String filter = "", sql = "";

		if (hasNameParam && hasCategoryParam) {
			filter = "<h3>Products containing '" + name + "' in category: '" + category + "'</h3>";
			name = '%' + name + '%';
			sql = "SELECT productId, productName, price, categoryName, img, description FROM Product WHERE productName LIKE ? AND categoryName = ?";
		} else if (hasNameParam) {
			filter = "<h3>Products containing '" + name + "'</h3>";
			name = '%' + name + '%';
			sql = "SELECT productId, productName, price, categoryName, img, description FROM Product WHERE productName LIKE ?";
		} else if (hasCategoryParam) {
			filter = "<h3>Products in category: '" + category + "'</h3>";
			sql = "SELECT productId, productName, price, categoryName, img, description FROM Product WHERE categoryName = ?";
		} else {
			filter = "<h3>All Products</h3>";
			sql = "SELECT productId, productName, price, categoryName, img, description FROM Product";
		}

		out.println(filter);

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		try {

			PreparedStatement pstmt = con.prepareStatement(sql);
			if (hasNameParam) {
				pstmt.setString(1, name);
				if (hasCategoryParam) {
					pstmt.setString(2, category);
				}
			} else if (hasCategoryParam) {
				pstmt.setString(1, category);
			}

			ResultSet rst = pstmt.executeQuery();

			out.print(
					"<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
			out.println("<th>Category</th><th>Price</th><th>Image</th></tr>");
			while (rst.next()) {
				out.print("<td class=\"col-md-1\"><a  href=\"addcart.jsp?id=" + rst.getInt(1) + "&name="
						+ rst.getString(2) + "&price=" + rst.getDouble(3) + "\" class =\"cart\">Add to Cart</a></td>");

				String itemCategory = rst.getString(4);
				String color = (String) colors.get(itemCategory);
				if (color == null)
					color = "#000000";

				out.println("<td><font color=\"" + color + "\">" + rst.getString(2) + "<br><br><br>Description: " + rst.getString(6)+"</font></td>"
						+ "<td><font color=\"" + color + "\">" + itemCategory + "</font></td>"
						+ "<td><font color=\"" + color + "\">" + currFormat.format(rst.getDouble(3))
						+ "</font></td><td><img src=\"" + rst.getString(5)
						+ "\" style=\"width:128npx;height:128px;\"></td></tr>");
			}
			out.println("</table></font>");
			con.close();
		} catch (SQLException ex) {
			out.println(ex);
		}
		%>
		</div> 
	
	<li><a href="login.jsp">SIGN IN</a></li>
        <li><a href="signUp.html">SIGN UP</a></li>
      </ul>
    </div>
  </div>
</nav>


	
</body>
</html>

<style>


.navbar {
    margin-bottom: 0;
   
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
         
}
.button {
        position:relative;
        padding:6px 15px;
        left:-8px;
        border:2px solid #007350;
        background-color:#007350;
        color:#fafafa;
      
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
