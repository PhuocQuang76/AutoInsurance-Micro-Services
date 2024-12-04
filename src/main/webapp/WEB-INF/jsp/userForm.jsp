<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Form</title>
    <style type="text/css">
        .error(color:red;)
    </style>
</head>
<body>
    <div align="center">
        <table>
            <tr>
                <td><a href="${pageRequest.request.contextPath}/home" />Home</td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/driverForm" />Role Form</td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/roleForm" />Role Form</td><td> | </td>
                <td><a href="${pageRequest.request.contextPath}/userForm" />User Form</td><td> | </td>

                <sec:authorize access="isAuthenticated()">
                    <td><a href="logout">Logout</a></td>
                </sec:authorize>
            </tr>
        </table>
        <h1>User Form</h1>

        <sec:authorize access="isAuthenticated()">
            <br>Logged In User:<sec:authentication property="principal.username"/>
            <br>Principal:<sec:authentication property="principal"/>
            <br>Password: <sec:authentication property="principal.password"/>
            <br>Enabled: <sec:authentication property="principal.enabled"/>
            <br> AccountNonExpired: <sec:authentication property="principal.accountNonExpired"/>
            <br>credentialsNonExpired: <sec:authentication property="principal.credentialsNonExpired"/>
            <br>AccountNonLocked: <sec:authentication property="principal.accountNonLocked"/>
            <br>Granted Authorities: <sec:authentication property="principal.authorities"/>
            <br> loggedInUser: ${loggedInUser}
            <br><a href="logout">Logout</a>
        </sec:authorize>

        <f:form action="saveUser"  modelAttribute="user">
        <h1>${loggedInUser}</h1>
            <table>
                <tr>
                    <td>User Id</td>
                    <td><f:input path="userId" value="${user.userId}"/></td>
                </tr>

                <tr>
                    <td>User Name</td>
                    <td><f:input path="username" value="${user.username}"/></td>

                </tr>
                <tr>
                    <td></td>
                    <td style="color:red;"><f:errors path="username" cssClass="error" /></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><f:password path="password" value="${user.password}"/></td>

                </tr>
                <tr>
                    <td></td>
                    <td style="color:red;"><f:errors path="password" cssClass="error" /></td>
                </tr>

                <tr>
                    <td>Email</td>
                    <td><f:input path="email" value="${user.email}"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td style="color:red;"><f:errors path="email" cssClass="error" /></td>
                </tr>

                <tr>
                    <td>Roles</td>
                    <td>
                        <c:forEach items="${roles}" var="role">
                            <c:if test="${retrievedRole.contains(role) }" >
                                <f:checkbox path="roles" label="${role.name}" value="${role.roleId}" checked="true"/>
                            </c:if>

                            <c:if test="${!retrievedRole.contains(role) }" >
                                <f:checkbox path="roles" label="${role.name}" value="${role.roleId}" />
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td style="color:red;"><f:errors path="roles" cssClass="error" /></td>
                </tr>
            </table>

            <input type="submit" value="submit"  class="btn btn-primary"  style="height:.7cm;width:2.5cm;"/>
        </f:form>
        <br>
        <hr>
        <h1>User List</h1>
        <table border="1">
            <thead>
                <tr><td>User Id</td><td>Name</td><td>Password</td><td>Email</td>
                    <td>Roles</td>
                    <td>Update</td>
                    <td>Delete</td>
                </tr>
            </thead>

            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user.getUserId() }</td>
                    <td>${user.getUsername() }</td>
                    <td>${user.getPassword() }</td>
                    <td>${user.getEmail() }</td>

                    <td>
                        <c:forEach items="${user.getRoles()}" var="role">
                            ${role.getName()}
                        </c:forEach>
                    </td>
                    <td><a href="${pageContext.request.contextPath}/updateUser?userId=${user.getUserId() }">Update</a></td>
                    <td><a href="${pageContext.request.contextPath}/deleteUser?userId=${user.getUserId() }">Delete</a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>