<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> <%-- 현재 페이지 내에서  빈즈가 사용될 수 있도록 --%>
<jsp:setProperty name="bbs" property="bbsTitle" /> <%-- 로그인 페이지에서 받아온 userID를 받아 한 명의 사용자에 userID 넣어주기 --%>
<jsp:setProperty name="bbs" property="bbsContent" />


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
		if ( userID == null ) {	// 세션이 없다면 
			PrintWriter script = response.getWriter();  
			script.println("<script>");	
			script.println("alert('로그인을 하세요!')");
			script.println("location.href = 'login.jsp'"); 
			script.println("</script>");	
		} else {	// 세션이 있다면 
			if ( bbs.getBbsTitle() == null || bbs.getBbsContent() == null ) {
					PrintWriter script = response.getWriter(); // 하나의 script 문장 넣어주기 
					script.println("<script>");	// println으로 script 문장 유동적으로 실행하도록~ 
					script.println("alert('입력이 안 된 사항이 있습니다!')");
					script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
					script.println("</script>");
				} else {
					BbsDAO bbsDAO = new BbsDAO(); // BbsDAO 인스턴스 생성
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); // 입력된 값 넣어주기
					if (result == -1) {
						PrintWriter script = response.getWriter(); // 하나의 script 문장 넣어주기 
						script.println("<script>");	// println으로 script 문장 유동적으로 실행하도록~ 
						script.println("alert('글쓰기에 실패하였습니다.')"); // 데이터베이스에 이미 아이디가 존재할 때
						script.println("history.back()"); // 이전 페이지로 사용자 돌려보내기
						script.println("</script>");	
					}
					
					else {	// result == 0 이외의 ~~ = 글쓰기 성공! 
						PrintWriter script = response.getWriter(); // 하나의 script 문장 넣어주기 
						script.println("<script>");	// println으로 script 문장 유동적으로 실행하도록~ 
						script.println("location.href = 'bbs.jsp'");	// 회원가입 성공시 메인 페이지로 이동! 
						script.println("</script>");	
					}
				}
		}
	%>
</body>
</html>