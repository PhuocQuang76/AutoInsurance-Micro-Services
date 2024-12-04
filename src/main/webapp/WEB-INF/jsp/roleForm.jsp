<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Role Form</title>
    <style type="text/css">
        .error(color:red;)
    </style>
</head>
<body>
    <div align="center">
        <table>
            <tr>
                <td><a href="${pageRequest.request.contextPath}/aileen/home" />Home</td><td> | </td>
                <td><a href="${pageContext.request.contextPath}/branchForm" />Branch Form</a></td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/aileen/roleForm" />Role Form</td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/aileen/userForm" />User Form</td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/aileen/customerForm" />Customer Form</td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/aileen/accountForm" />Account Form</td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/aileen/bankTransactionForm" />Transaction Form</td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/aileen/searchForm" />Search Form</td><td> | </td>

                <sec:authorize access="isAuthenticated()">
                    <td><a href="logout">Logout</a></td>
                </sec:authorize>
            </tr>
        </table>
        <h1>Role Form</h1>

        <f:form action="saveRole" method="POST" modelAttribute="role">
            <table>
                <tr>
                    <td>Role Id</td>
                    <td><f:input path="roleId" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Role Name</td>
                    <td><f:input path="name" /></td>

                </tr>
                <tr>
                    <td></td>
                    <td style="color:red;"><f:errors path="name" /></td>
                </tr>
            </table>
            <input type="submit" value="submit"  class="btn btn-primary"  style="height:.7cm;width:2.5cm;"/>
        </f:form>

        <br>
        <hr>
        <h1>Role List</h1>
        <table border ="1">
            <tr>
                <td>Role Id</td>
                <td>Role Name</td>
            <tr>
            <c:forEach items="${roles}" var="role" >
                <tr>
                    <td>${role.getRoleId()}</td>
                    <td>${role.getName()}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>