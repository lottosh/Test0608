<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	String email = request.getParameter("email");
	String content = request.getParameter("content");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	int result = 0;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://127.0.0.1:3306/jspdb?characterEncoding=utf8";
		String id = "root";
		String dbpw = "1234";
		conn = DriverManager.getConnection(url,id,dbpw);	
		
		String sql = "insert into guestbook values (null, ?,?,?,?)";
		pstmt = conn.prepareStatement(sql); // ����� + ���� �غ�
		
		pstmt.setString(1, name);// ���ڴ� ?�� ��ġ ��ȣ
		pstmt.setString(2, pw);
		pstmt.setString(3, email);
		pstmt.setString(4, content);// �غ� �� �� �ֱ�
		
		result = pstmt.executeUpdate();// int �� ���
		
		if(result>0){
			response.sendRedirect("Ex1.jsp");
		}else{
			out.println("���� �߻�!");
		}
				
	}catch(ClassNotFoundException cnfe){
		
	}catch(SQLException sqle){
		
	}finally{
		try{
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}catch(SQLException sqle){
			
		}
	}
		
%>
</body>
</html>


