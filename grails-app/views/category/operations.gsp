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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1>Liste des opérations <small>${category.name}</small></h1>
    <hr/>
</div>

<div class="col-sm-6">

    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:render template="/operation/simplelist" model="[operations: operations]"/>

    </div>
</div>

<div class="col-sm-6">

    <div class="around-border">
        <g:render template="/generic/statsfilter"
                  model="[id: category.id, action: 'operations', controller: 'category']"/>
    </div><br/>

    <div class="around-border">

        <div class="alert alert-info">Statistiques</div>


        <g:render template="/generic/chart"
                  model="[name      : 'OpChart', controller: 'category', action: 'operationsChart',
                          parameters: ['id': category.id, 'fromYear': fromYear, 'toYear': toYear]]"/>

    </div>
</div>
</body>
</html>
