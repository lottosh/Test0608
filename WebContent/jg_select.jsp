<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jg_include_sel.jspf" %>    
<table>    
    
<%	
	try{	
		String sql = "select * from guestbook";		
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){
%>
		<tr style="background-color: orange;">
			<td><%=rs.getInt("idx")%></td>
			<td><%=rs.getString("name")%></td>
			<td><%=rs.getString("email")%>
				<%-- <a href="jg_md.jsp?idx=<%//=rs.getInt("idx")%>">M/D</a> --%>
<input type="button" value="M/D" style="width: 50px;" onclick="location.href='jg_md.jsp?idx=<%=rs.getInt("idx")%>'">
			</td>
		</tr>		
		<tr>
			<td colspan="3">
			<%=rs.getString("content").replace("\r\n", "<br>") %></td>			
		</tr>
<%		
		}		
	}catch(SQLException sqle){
		sqle.printStackTrace();
	}finally{
		try{
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}catch(SQLException sqle){
			sqle.printStackTrace();
		}
	}
%>

</table>