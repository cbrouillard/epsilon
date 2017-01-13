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
<%@ page import="com.headbangers.epsilon.Operation" %>
<span class="pull-right" >
    <g:link controller="${document.type.controllerName}" action="edit" id="${linked?.id}">
        <img src="${assetPath(src:'edit.png')}"/>
    </g:link>
</span>
<ul class="list-inline">

    <g:if test="${linked && linked instanceof com.headbangers.epsilon.Operation}">
        <g:set var="operation" value="${(com.headbangers.epsilon.Operation) linked}"/>
        <li><g:formatDate date="${operation.dateApplication}"/></li>
        <li>${operation.category.name} - ${operation.tiers.name}</li>
        <li><g:formatNumber number="${operation?.amount}" format="###,###.##"/> €</li>
    </g:if>

    <g:if test="${linked && linked instanceof com.headbangers.epsilon.Account}">
        <g:set var="account" value="${(com.headbangers.epsilon.Account) linked}"/>
        <li>${account.name}</li>
    </g:if>

    <g:if test="${linked && linked instanceof com.headbangers.epsilon.Bank}">
        <g:set var="bank" value="${(com.headbangers.epsilon.Bank) linked}"/>
        <li>${bank.name}</li>
    </g:if>
</ul>

<div class="clearfix"></div>