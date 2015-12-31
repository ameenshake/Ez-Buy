<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Item</title>
</head>
<body>





	<form action="del.jsp" method="post">
		<center>
			<table border="1" cellpadding="5" width="30%">
				<thead>
					<tr>
						<th colspan="2">Delete item</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Product Id</td>
						<td><select size="1" name="productId"
							onchange="if (this.selectedIndex) doSomething();">
							
								<%
									Connection con = null;
									try {
										Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
									} catch (ClassNotFoundException ce) {
										System.err.println(ce);
									}

									// Could create category list dynamically - more adaptable, but a little more costly
									try {

										con = DriverManager.getConnection("jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jbutler",
												"jbutler", "41498130");
										ResultSet rst = con.createStatement().executeQuery("SELECT DISTINCT productId FROM Product");
										while (rst.next())
											out.println("<option>" + rst.getString(1) + "</option>");
									} catch (SQLException ex) {
										out.println(ex);
									}
								%>
						</select></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;"><input
							type="submit" value="Delete" /></td>
					</tr>
					</td>
					</tr>
				</tbody>
			</table>
		</center>
	</form>


</body>
</html>