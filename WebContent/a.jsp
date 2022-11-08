<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="common.jdbc.JdbcTemplate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 a 파일</title>
</head>
<body>
임시 a 파일<br>
<%
//	String sqlInsert = "insert into dept values(seq_test1.nextval, 'abc', 'seoul')";
	String sqlInsert = "insert into dept values(seq_test1.nextval, ?, ?)"; // 밑에서 set~로 입력받기
//	String sql = "select * from dept where dname like '%E%'";
	String sql = "select * from dept where dname like ?"; // ?는 따옴표,와일드카드(% _)와 함께 사용 불가
	Connection conn = JdbcTemplate.getConnection();
	
	PreparedStatement pstmt = conn.prepareStatement(sqlInsert);
	// sql문 작성 + pstmt 생성 이후 ~ pstmt를 execute하기 이전
	// 딱 요 위치에서 ?에 값 넣어주기
	pstmt.setString(1, "abc"); // 1번째 ?에 "abc" 넣어줘
	pstmt.setString(2, "seoul");
	int result = pstmt.executeUpdate(); // insert/update/delete로 변경된 행의 '개수' 반환
	
	//pstmt.close(); --> 이렇게 닫지 말고
	JdbcTemplate.close(pstmt); // 이렇게 닫아주고 밑에서 다시 사용 (찌꺼기 남아있어서 닫아야함)
%>
	<br> insert 개수는 <%= result %> <br>
<%
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, "%O%");
	ResultSet rest = pstmt.executeQuery();
	
	while(rest.next()) {
%>
	<%= rest.getInt(1) %> | <%= rest.getString(2) %> | <%= rest.getString(3) %> <br>
<%
	} // while 끝
	
	JdbcTemplate.close(rest); // 생성의 역순으로 닫기
	JdbcTemplate.close(pstmt);
	JdbcTemplate.close(conn);
%>
</body>
</html>