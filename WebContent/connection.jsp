<html>
<head>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.InitialContext, javax.naming.Context"%>
<title>Insert title here</title>
</head>
<body>
	<%
		InitialContext initCtx = new InitialContext();
		Context envContext = (Context)initCtx.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/WEB");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("SELECT VERSION();");
		while(rset.next()) {
			out.println("MySQL Version: " + rset.getString("version()"));
		}
		rset.close();
		stmt.close();
		initCtx.close();
	%>
</body>
</html>