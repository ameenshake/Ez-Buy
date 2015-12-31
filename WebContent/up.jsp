<%@ page import="java.sql.*"%>
<%
String productId = request.getParameter("productId");
	String productName = request.getParameter("productName");
	String description = request.getParameter("description");
	String price = request.getParameter("price");
	String img = request.getParameter("img");
	String wh = request.getParameter("wh");

	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jbutler;";
	String uid = "jbutler";
	String pw = "41498130";

	Connection con = DriverManager.getConnection(url, uid, pw);

	Statement st = con.createStatement();
	//ResultSet rs;
	int i = st.executeUpdate("update Product SET productName='" +productName+ "', description='" + description + "', Price='" + price + "',img='"
			+ img + "' WHERE productId = " + productId);
	int j = st.executeUpdate("update  Warehouse SET amount ='" + wh + "' WHERE productId = " + productId);
	if (i > 0 && j > 0) {
		//session.setAttribute("userid", user);

		response.sendRedirect("admin.html");
		out.print("Update Successfull!" + "<a href='index.jsp'>Go to Login</a>");
	} else {
		response.sendRedirect("index.jsp");
	}
%>