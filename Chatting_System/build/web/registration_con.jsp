<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Connection</title>
    </head>
    <body>
        <!--value call from login page-->
        <c:set scope="page" var="PHONENO" value="${param.phoneno}"></c:set>
        <c:set var="i" value="1"></c:set>
        
        <!--Database Connection-->
        <sql:setDataSource driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/chat_system" user="root" password="12345" var="check"></sql:setDataSource>
        <sql:query dataSource="${check}" var="rs">select * from userreg where phoneno=? <sql:param value="${PHONENO}"></sql:param></sql:query>
        
        <!--Show details inside the DB-->
        <c:forEach items="${rs.rows}" var="row">
            <c:set var="CPHONENO" value="${row.phoneno}"></c:set>
            
            <c:if test="${PHONENO == CPHONENO}">
                <c:set var="i" value="0"></c:set>
            </c:if>

        </c:forEach>
        
        <c:if test="${i==0}">
            <%
                String message = "This phone number has already registred";
                RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
                request.setAttribute("msg",message);
                rd.forward(request, response);
            %>
        </c:if>
        
        <c:if test="${i==1}">
            <sql:update dataSource="${check}" var="insert">insert into userreg(firstname, lastname, gender, phoneno, emailid, password, secure_question, answer, status, images) values(?, ?, ?, ?, ?, ?, ?, ?,'offline','user.png');
                <sql:param value="${param.firstname}" />
                <sql:param value="${param.lastname}" />
                <sql:param value="${param.gender}" />
                <sql:param value="${PHONENO}" />
                <sql:param value="${param.emailid}" />
                <sql:param value="${param.password}" />
                <sql:param value="${param.secure_question}" />
                <sql:param value="${param.answer}" />
            </sql:update>
            
            <sql:update dataSource="${check}" var="create">
                create table ocs${PHONENO} (chatid int NOT NULL AUTO_INCREMENT,fromuser varchar(15) NOT NULL,touser varchar(15) NOT NULL,message varchar(500) NOT NULL,chat_date varchar(50) NOT NULL,PRIMARY KEY (chatid));
            </sql:update>
                
            <%
                String message1 = "You are Sucessfully registred";
                RequestDispatcher rd1 = request.getRequestDispatcher("login.jsp");
                request.setAttribute("msg1",message1);
                rd1.forward(request, response);
            %>
        </c:if>
        
    </body>
</html>