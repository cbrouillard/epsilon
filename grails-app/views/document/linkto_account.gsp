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
<%@ page import="com.headbangers.epsilon.AccountType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}"/>
    <title><g:message code="document.${document.type.toString().toLowerCase()}.linkto"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="document.${document.type.toString().toLowerCase()}.linkto"/>
        <small><g:message code="document.${document.type.toString().toLowerCase()}.linkto.explanation"/></small></h1>
    <hr/>
</div>

<div class=" col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                <tr>

                    <th><g:message code="account.bank.label" default="Bank"/></th>

                    <g:sortableColumn property="name"
                                      title="${message(code: 'account.name.label', default: 'Name')}"/>

                    <g:sortableColumn property="type"
                                      title="${message(code: 'account.type.label', default: 'Type')}"/>

                    <g:sortableColumn property="dateOpened"
                                      title="${message(code: 'account.dateOpened.label', default: 'Date Opened')}"/>

                    <th><g:message code="details"/></th>
                    <g:sortableColumn property="amount"
                                      title="${message(code: 'account.calculatedAmount.label', default: 'Amount')}"
                                      class="text-right"/>


                    <th class="text-right"><g:message code="actions"/></th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${accounts}" status="i" var="accountInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                        <td>${fieldValue(bean: accountInstance, field: "bank.name")}</td>
                        <td>${fieldValue(bean: accountInstance, field: "name")}</td>
                        <td>${fieldValue(bean: accountInstance, field: "type")}</td>
                        <td><g:formatDate date="${accountInstance.dateOpened}"/></td>
                        <td>${accountInstance.description}</td>
                        <td class="text-right"><b><g:formatNumber number="${accountInstance?.sold}"
                                                                  format="###,###.##"/> €</b></td>
                        <td class="text-right">
                            <g:link controller="account" action="linkdocument"
                                    id="${accountInstance.id}" params="[docId: document.id]">
                                <img src="${assetPath(src: "enter.png")}"
                                     alt="Action"/>
                            </g:link>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>