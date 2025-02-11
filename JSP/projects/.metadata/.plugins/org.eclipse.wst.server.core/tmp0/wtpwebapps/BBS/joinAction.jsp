<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page" /> <%-- 현재 페이지 내에서  빈즈가 사용될 수 있도록 --%>
<jsp:setProperty name="user" property="userID" /> <%-- 로그인 페이지에서 받아온 userID를 받아 한 명의 사용자에 userID 넣어주기 --%>
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
		String userID = null;
		if ( session.getAttribute("userID") != null ) {
			userID = (String) session.getAttribute("userID"); // userID라는 이름으로 세션이 존재하는 회원들은 userID에 해당 세션값 넣기
		}
		if ( userID != null ) {
			PrintWriter script = response.getWriter();  
			script.println("<script>");	
			script.println("alert('이미 로그인이 되어있습니당.')");
			script.println("location.href = 'main.jsp'"); 
			script.println("</script>");	
		}
		if ( user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserGender() == null || user.getUserEmail() == null ) {
			PrintWriter script = response.getWriter(); // 하나의 script 문장 넣어주기 
			script.println("<script>");	// println으로 script 문장 유동적으로 실행하도록~ 
			script.println("alert('입력이 안 된 사항이 있습니다!')");
			script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO(); // userDAO 인스턴스 생성
			int result = userDAO.join(user); // 입력된 값 넣어주기
			if (result == -1) {
				PrintWriter script = response.getWriter(); // 하나의 script 문장 넣어주기 
				script.println("<script>");	// println으로 script 문장 유동적으로 실행하도록~ 
				script.println("alert('이미 존재하는 아이디입니다.')"); // 데이터베이스에 이미 아이디가 존재할 때
				script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
				script.println("</script>");	
			}
			
			else {	// result == 0 이외의 ~~ 
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter(); // 하나의 script 문장 넣어주기 
				script.println("<script>");	// println으로 script 문장 유동적으로 실행하도록~ 
				script.println("location.href = 'main.jsp'");	// 회원가입 성공시 메인 페이지로 이동! 
				script.println("</script>");	
			}
		}
	%>
</body>
</html>