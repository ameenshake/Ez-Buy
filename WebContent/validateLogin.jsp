<%@ page import="java.sql.*"%>
<%
	String userid = request.getParameter("uname");
	String pwd = request.getParameter("pass");
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jbutler;";
	String uid = "jbutler";
	String pw = "41498130";

	if (userid.equals("admin") && pwd.equals("admin")) {
		response.sendRedirect("admin.html");
	} else {
		Connection con = DriverManager.getConnection(url, uid, pw);
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from Customer where userID='" + userid + "' and pswd='" + pwd + "'");
		if (rs.next()) {
			session.setAttribute("userid", userid);
			// out.println("welcome " + userid);
			// out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("sucess.jsp");
		} else {
			out.println("Invalid Username or Password <a href='login.jsp'>try again</a>");
		}
	}
%>