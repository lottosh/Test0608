<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
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

		String content = request.getParameter("content");

	 	Connection conn = null;
		PreparedStatement pstmt = null;// ������ ����Ŵ� Statement ����
		ResultSet rs = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://127.0.0.1:3306/jspdb?characterEncoding=utf8";
			String id = "root";
			String pw = "1234";
			conn = DriverManager.getConnection(url,id,pw);		
						
			//String sql = "SELECT * FROM guestbook WHERE content LIKE '%����%'";
			//�������� �˻� �ϱ� ���� ������ �ۼ�
			// content ��� ��
			System.out.println(content+"#");
//			String sql = "SELECT * FROM guestbook WHERE content LIKE ?"; // 1)��
			// like ��쿡 �Ϲ����� ������ preparedstatement�� �Ұ����ϴ�
			// statement ���´� �������
			
			String sql = "SELECT * FROM guestbook WHERE content LIKE '%" +content +"%'"; // 2��)
			pstmt=conn.prepareStatement(sql);
//			pstmt.setString(1, "%"+content+"%"); // 1��)
			//pstmt.setInt(1);
			rs = pstmt.executeQuery();// ����
			
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