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
		String idx = request.getParameter("idx");

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
			
			//String sql = "select * from guestbook where idx="+idx;// 원래 형태
			String sql = "select * from guestbook where idx=?";// preparedstatement
			// 넘어온 변수가 들어가 잘자리에 직접 변수를 추가하지 않고 ? 로 미리 준비해서 써둔다
			// statement의 ' ' <== 홑따옴표는 특수한 경우가 아니면 더이상 쓰지 않는다. 		
			// 이후 실행전에 값만 넣어준다.		
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(idx));
			// set타입 이기때문에 값도 타입에 맞춰야 한다.
			
			rs = pstmt.executeQuery();// 실행
			
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