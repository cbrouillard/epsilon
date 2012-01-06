<!-- 
/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
-->
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
            <h1>Graphe des dépenses pour le mois en cours</h1>
            <div class="help">Attention ! Ce graphique ne montre que les opérations de dépense.</div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="chart" id="opChart">
              <g:render template="/generic/chart"  model="[name:'OpChart', controller:'stats', action:'operationsChart', forcedWidth:'700px']"/>
            </div>
        </div>
    </body>
</html>
