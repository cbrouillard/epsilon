
<%@ page import="com.headbangers.epsilon.Category" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des catégories</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouvelle catégorie</g:link></span>
        </div>
        <div class="body">
            <h1>Liste des opérations pour '${category.name}'</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="chart" id="opChart">
              <g:render template="/generic/chart"  model="[name:'OpChart', controller:'category', action:'operationsChart', params:['id':category.id], forcedWidth:'600px']"/>
            </div>
            <g:render template="/operation/simplelist" model="[operations:category.operations]"/>
        </div>
    </body>
</html>
