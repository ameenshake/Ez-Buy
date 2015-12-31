<%@ page import="java.sql.*"%>
<%
String productId = request.getParameter("productId");

	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jbutler;";
	String uid = "jbutler";
	String pw = "41498130";

	Connection con = DriverManager.getConnection(url, uid, pw);

	Statement st = con.createStatement();
	//ResultSet rs;
	int i = st.executeUpdate("delete from Product Where productId=" +productId);
	if (i > 0 ) {
		//session.setAttribute("userid", user);

		response.sendRedirect("admin.html");
		//out.print("Update Successfull!" + "<a href='index.jsp'>Go to Login</a>");
	} else {
		response.sendRedirect("index.jsp");
	}
%>