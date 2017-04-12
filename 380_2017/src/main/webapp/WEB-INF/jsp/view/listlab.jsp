<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body>
      <security:authorize access="isAuthenticated()">
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        </security:authorize>  
        <h2>All Post</h2>

        <security:authorize access="hasRole('ADMIN')">    
            <a href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
        </security:authorize>
        <security:authorize access="isAuthenticated()">
        <a href="<c:url value="/ticket/create" />">New Post</a>  
        </security:authorize>       
        <a href="<c:url value="/ticket/listlecture" />">lecture</a>
        <a href="<c:url value="/ticket/listlab" />">lab</a>
        <a href="<c:url value="/ticket/listother" />">other</a>
        <a href="<c:url value="/ticket/list" />">all</a>
                <security:authorize access="isAnonymous()">
        <a href="<c:url value="/login" />">login</a>
        </security:authorize>  
        <br /><br />
        <c:choose>
            <c:when test="${fn:length(ticketDatabase) == 0}">
                <i>0 Post.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${ticketDatabase}" var="entry3">
                    <c:if test="${entry3.categories == 'lab'}" >
                        Post #${entry3.id}:
                        <a href="<c:url value="/ticket/view/${entry3.id}" />"> 
                            <c:out value="${entry3.subject}" /></a>
                        (Post by: <c:out value="${entry3.customerName}" />)     
                        <security:authorize access="isAuthenticated()">
                    <security:authorize access="hasRole('ADMIN') or principal.username=='${entry3.customerName}'">            
                        [<a href="<c:url value="/ticket/edit/${entry3.id}" />">Edit</a>]
                    </security:authorize>
                      </security:authorize>  
                    <security:authorize access="hasRole('ADMIN')">            
                        [<a href="<c:url value="/ticket/delete/${entry3.id}" />">Delete</a>]
                    </security:authorize>
                    <hr>
                    </c:if>  
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </body>
</html>