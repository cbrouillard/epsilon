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
<%@ page import="com.headbangers.epsilon.Bank" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'bank.label', default: 'Bank')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Liste des établissements <small>Banques, assurances, ...</small> <g:link controller="bank" action="create" class="btn"><img
                        src="${resource(dir: 'img', file: 'bank.png')}"
                        alt=">"/> Créer un nouvel établissement</g:link></h1>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">

                <g:if test="${!bankInstanceList}">
                    <div class="alert alert-error">Aucun établissement enregistré !</div>
                </g:if>
                <g:else>
                    <g:if test="${flash.message}">
                        <div class="alert alert-info">${flash.message}</div>
                    </g:if>


                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>

                            <g:sortableColumn property="name" title="${message(code: 'bank.name.label', default: 'Name')}"/>

                            <g:sortableColumn property="description" title="${message(code: 'bank.description.label', default: 'Description')}"/>

                            <g:sortableColumn property="dateCreated" title="${message(code: 'bank.dateCreated.label', default: 'Date Created')}"/>

                            <g:sortableColumn property="lastUpdated" title="${message(code: 'bank.lastUpdated.label', default: 'Last Updated')}"/>

                            <th>Actions</th>

                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${bankInstanceList}" status="i" var="bankInstance">
                            <tr>

                                <td>${fieldValue(bean: bankInstance, field: "name")}</td>

                                <td>${fieldValue(bean: bankInstance, field: "description")}</td>

                                <td><g:formatDate date="${bankInstance.dateCreated}"/></td>

                                <td><g:formatDate date="${bankInstance.lastUpdated}"/></td>

                                <td class="tdcenter">
                                    <g:link title="Afficher les détails" action="show" data-toggle="modal" data-target="#modalWindow_show"
                                            id="${bankInstance.id}"><img src="${resource(dir: 'img', file: 'details.png')}"/></g:link>
                                    <g:link title="Editer" action="edit" id="${bankInstance.id}"><img src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>

                    <div class="pagination text-right">
                        <g:paginate total="${bankInstanceTotal}"/>
                    </div>
                </g:else>

            </div>
        </div>
    </div>
</div>

<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'un établissement</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>

</body>
</html>
