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
    <title><g:message code="category.operations"/></title>
</head>

<body>
<div class="col-sm-12">
    <g:render template="/generic/statsfilter"
              model="[id: category.id, action: 'operations', controller: 'category', css: 'margin-top: 25px;']"/>
    <h1><g:message code="category.operations"/> <small>${category.name}</small></h1>

    <hr class="clearfix"/>
</div>

<div class="col-sm-6">

    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <div class="pull-right">
            <span><small><g:message code="actions"/> : </small></span>
            <span>
              <g:link title="Fusionner" action="askmerge" id="${category.id}">
              <img src="${assetPath(src: 'merge.png')}"/>
              </g:link>
            </span>
            <span>
                <g:link title="Editer" action="edit" id="${category.id}"><img
                        src="${assetPath(src: 'edit.png')}"/></g:link>
            </span>

            <span id="category${category.id}-pinned">
                <g:render template="pinnedactions" model="[category: category]"/>
            </span>
        </div>

        <div class="clearfix">&nbsp;</div>
        <hr/>

        <g:render template="/operation/simplelist" model="[operations: operations, highlightMonth: currentMonth, showTotal:true]"/>

    </div>
</div>

<div class="col-sm-6">

    <div class="around-border">

        <div class="alert alert-info"><g:message code="stats"/></div>

        <g:render template="/chart/operationsByMonth" model="[operations: operations, category: category]"/>

    </div>
</div>
</body>
</html>
