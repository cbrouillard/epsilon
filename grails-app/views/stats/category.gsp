
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
          <span class="menuButton"><g:link class="stats" action="category">Dépenses/catégories</g:link></span>
          <span class="menuButton"><g:link class="stats" action="revenues">Revenus/catégories</g:link></span>
<!--          <span class="menuButton"><g:link class="stats" action="operations">Dépenses/mois</g:link></span>-->
        </div>
        <div class="body">
            <h1>Graphe des dépenses pour les catégories</h1>
            <div class="help">Attention ! Ce graphique ne montre que les catégories de type "Dépense"</div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="chart" id="opChart">
              <g:render template="/generic/chart"  model="[name:'OpChart', controller:'stats', action:'categoryChart', forcedWidth:'700px']"/>
            </div>
        </div>
    </body>
</html>
