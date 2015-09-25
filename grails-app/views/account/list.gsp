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
<div class="col-sm-12">
    <h1>Liste des comptes <small>Tous vos comptes sont ici.</small> <g:link controller="account" action="create"
                                                                            class="btn btn-success"><img
                src="${resource(dir: 'img', file: 'account.png')}"
                alt=">"/> Créer un nouveau compte</g:link></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${!accountInstanceList}">
            <div class="alert alert-danger">Aucun compte enregistré.
            </div>
        </g:if>
        <g:else>
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

                        <th>Détails</th>
                        <g:sortableColumn property="amount"
                                          title="${message(code: 'account.calculatedAmount.label', default: 'Amount')}"
                                          class="text-right"/>


                        <th class="text-right">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${accountInstanceList}" status="i" var="accountInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td>${fieldValue(bean: accountInstance, field: "bank.name")}</td>

                            <td>${fieldValue(bean: accountInstance, field: "name")}</td>

                            <td>${fieldValue(bean: accountInstance, field: "type")}</td>

                            <td><g:formatDate date="${accountInstance.dateOpened}"/></td>

                            <td>${accountInstance.description}</td>
                            <td class="text-right"><b><g:formatNumber number="${accountInstance?.sold}"
                                                                      format="0.##"/> €</b></td>

                            <td class="text-right">
                                <g:link title="Afficher les détails" action="show" id="${accountInstance.id}"
                                        data-toggle="modal"
                                        data-target="#modalWindow_show"><img
                                        src="${resource(dir: 'img', file: 'details.png')}"/></g:link>

                                <g:link title="Editer" action="edit" id="${accountInstance.id}"><img
                                        src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                                <g:link title="Afficher le registre" controller="operation" action="list"
                                        params="[account: accountInstance.id]"><img
                                        src="${resource(dir: 'img', file: 'operation.png')}"/></g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

            <div class="pagination pull-right">
                <g:paginate total="${accountInstanceTotal}"/>
            </div>

            <div class="clearfix">&nbsp;</div>
        </g:else>

    </div>
</div>

<div class="modal fade" id="modalWindow_show" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        </div>
    </div>
</div>

</body>
</html>
