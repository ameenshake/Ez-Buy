<%@ page import="java.sql.*"%>
<%
	String userID = request.getParameter("userID");
	String pswd = request.getParameter("pswd");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String cAddress = request.getParameter("cAddress");
	String city = request.getParameter("city");
	String postalcode = request.getParameter("postalcode");
	String province = request.getParameter("province");
	String country = request.getParameter("country");
	String phonenumber = request.getParameter("phonenumber");
	String email = request.getParameter("email");

	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jbutler;";
	String uid = "jbutler";
	String pw = "41498130";

	Connection con = DriverManager.getConnection(url, uid, pw);

	Statement st = con.createStatement();
	//ResultSet rs;
	int i = st.executeUpdate(
			"insert into Customer(userID, pswd, firstName, lastName, cAddress, city, postalcode, province, country, phonenumber, email) values ('"
					+ userID + "','" + pswd + "','" + firstName + "','" + lastName + "','" + cAddress + "','"
					+ city + "','" + postalcode + "','" + province + "','" + country + "','" + phonenumber
					+ "','" + email + "')");
	if (i > 0) {
		//session.setAttribute("userid", user);

		response.sendRedirect("checkout.jsp");
		// out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
	} else {
		response.sendRedirect("index.jsp");
	}
%>