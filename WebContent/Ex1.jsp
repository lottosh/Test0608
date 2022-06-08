<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	Statement =  실행기 준비 -> 만들어진 쿼리 담아서 실행<br>
	PreparedStatement = 실행기 준비+쿼리 미리 담기 -> 쿼리에 들어갈 값만 후 세팅 후 실행<br><br>
	
	<form action="Ex1-2.jsp">
		번호 입력 : <input type="text" name="idx">
		<input type="submit">	
	</form>
	
	<form action="Ex1-3.jsp">
		내용 입력 : <input type="text" name="content">
		<input type="submit">	
	</form>
	<br>
	<form action="Ex1-4.jsp">
		이름 : <input type="text" name="name">
		비밀번호 : <input type="text" name="pw">
		이메일 : <input type="text" name="email">
		내용 : <input type="text" name="content">
		<input type="submit">	
	</form>
	<br><br>
	<%
	 	Connection conn = null;
		PreparedStatement pstmt = null;// 이전에 썼던거는 Statement 였음
		ResultSet rs = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://127.0.0.1:3306/jspdb";
			String id = "root";
			String pw = "1234";
			conn = DriverManager.getConnection(url,id,pw);		
			
			/*
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			*/
			
			String sql = "select * from guestbook";
			pstmt=conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				out.print(rs.getInt(1)+"/");
				out.print(rs.getString(2)+"/");
				out.print(rs.getString(3)+"/");
				out.print(rs.getString(4)+"/");
				out.print(rs.getString(5)+"<br>");
			}
			
		}catch(ClassNotFoundException cnfe){
			
		}catch(SQLException sqle){
			
		}finally{
			try{
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(SQLException sqle){
				
			}
		}
		
	%>
	
</body>
</html>



