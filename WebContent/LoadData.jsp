<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Scanner"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Load Data</title>
</head>
<body>


	<%
		try {
			try {
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			} catch (ClassNotFoundException ce) {
				System.err.println(ce);
			}
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_jbutler;";
			String uid = "jbutler";
			String pw = "41498130";

			System.out.println("Connecting to database.");

			Connection con = DriverManager.getConnection(url, uid, pw);

			String fileName = application.getRealPath("/")+"Data/order_sql.ddl";

			try {
				// Create statement
				Statement stmt = con.createStatement();

				Scanner scanner = new Scanner(new File(fileName));
				// Read commands separated by ;
				scanner.useDelimiter(";");
				while (scanner.hasNext()) {
					String command = scanner.next();
					if (command.trim().equals(""))
						continue;
					System.out.println(command); // Uncomment if want to see commands executed
					try {
						stmt.execute(command);
					} catch (Exception e) { // Keep running on exception.  This is mostly for DROP TABLE if table does not exist.
						System.out.println(e);
					}
				}
				scanner.close();
			} catch (Exception e) {
				System.out.println(e);
			}
		} catch (Exception e) {
			out.print(e);
		}
	finally {
		out.print("<h1>The Data Has Been Loaded!</h1>");
	}
	
	
	%>
	
	

</body>
</html>