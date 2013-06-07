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
<%@ page import="com.headbangers.epsilon.Account" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Liste des comptes <small>Tous vos comptes sont ici.</small> <g:link controller="account" action="create" class="btn"><img
                        src="${resource(dir: 'img', file: 'account.png')}"
                        alt=">"/> Créer un nouveau compte</g:link></h1>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">

                <g:if test="${!accountInstanceList}">
                    <div class="alert alert-error">Aucun compte enregistré.</div>
                </g:if>
                <g:else>
                    <g:if test="${flash.message}">
                        <div class="alert alert-info">${flash.message}</div>
                    </g:if>

                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>

                            <th><g:message code="account.bank.label" default="Bank"/></th>

                            <g:sortableColumn property="name" title="${message(code: 'account.name.label', default: 'Name')}"/>

                            <g:sortableColumn property="type" title="${message(code: 'account.type.label', default: 'Type')}"/>

                            <g:sortableColumn property="dateOpened" title="${message(code: 'account.dateOpened.label', default: 'Date Opened')}"/>

                            <g:sortableColumn property="amount" title="${message(code: 'account.calculatedAmount.label', default: 'Amount')}"/>

                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${accountInstanceList}" status="i" var="accountInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td>${fieldValue(bean: accountInstance, field: "bank.name")}</td>

                                <td>${fieldValue(bean: accountInstance, field: "name")}</td>

                                <td>${fieldValue(bean: accountInstance, field: "type")}</td>

                                <td><g:formatDate date="${accountInstance.dateOpened}"/></td>

                                <td class="tdright"><b><g:formatNumber number="${accountInstance?.sold}" format="0.##"/> €</b></td>

                                <td class="tdcenter">
                                    <g:link title="Afficher les détails" action="show" id="${accountInstance.id}" data-toggle="modal"
                                            data-target="#modalWindow_show"><img
                                            src="${resource(dir: 'img', file: 'details.png')}"/></g:link>

                                    <g:link title="Editer" action="edit" id="${accountInstance.id}"><img
                                            src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                                    <g:link title="Afficher le registre" controller="operation" action="list" params="[account: accountInstance.id]"><img
                                            src="${resource(dir: 'img', file: 'operation.png')}"/></g:link>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>

                    <div class="pagination text-right">
                        <g:paginate total="${accountInstanceTotal}"/>
                    </div>

                </g:else>

            </div>
        </div>
    </div>

</div>

<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'un compte</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>

</body>
</html>
