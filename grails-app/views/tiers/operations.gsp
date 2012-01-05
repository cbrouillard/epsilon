
<%@ page import="com.headbangers.epsilon.Tiers" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tiers.label', default: 'Tiers')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des tiers</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouveau tiers</g:link></span>
        </div>
        <div class="body">
            <h1>Liste des opérations pour '${tiers.name}'</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="chart" id="test">
              <g:render template="/generic/chart"  model="[name:'OpChart', controller:'tiers', action:'operationsChart', params:['id':tiers.id]]"/>
            </div>
            <g:render template="/operation/simplelist" model="[operations:tiers.operations]"/>
        </div>
    </body>
</html>
