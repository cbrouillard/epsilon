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
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Liste des catégories <small>Types de dépenses ou dépôts</small> <g:link controller="category" action="create" class="btn"><img
                        src="${resource(dir: 'img', file: 'category.png')}"
                        alt=">"/> Créer une nouvelle catégorie</g:link></h1>

                <div class="alert alert-info">
                    Chaque opération est rangée dans une catégorie.<br/>
                    Voici la liste de toutes les catégories connues du système.
                    Notez qu'il est inutile de créer toutes vos catégories au cas par cas : elles seront automatiquement
                    ajoutées au fur et à mesure de vos dépenses/dépôts/virements.
                </div>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">

                <div class="text-right">
                    <g:render template="/generic/search"/>
                </div>

                <g:if test="${flash.message}">
                    <div class="alert alert-info">${flash.message}</div>
                </g:if>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <g:sortableColumn property="name" title="${message(code: 'category.name.label', default: 'Name')}"/>

                        <g:sortableColumn property="type" title="${message(code: 'category.type.label', default: 'Type')}"/>

                        <g:sortableColumn property="description" title="${message(code: 'category.description.label', default: 'Description')}"/>

                        <g:sortableColumn property="dateCreated" title="${message(code: 'category.dateCreated.label', default: 'Date Created')}"/>

                        <g:sortableColumn property="lastUpdated" title="${message(code: 'category.lastUpdated.label', default: 'Last Updated')}"/>

                        <th>Solde</th>

                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${categoryInstanceList}" status="i" var="categoryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td>${fieldValue(bean: categoryInstance, field: "name")}</td>

                            <td>${fieldValue(bean: categoryInstance, field: "type")}</td>

                            <td>${fieldValue(bean: categoryInstance, field: "description")}</td>

                            <td><g:formatDate date="${categoryInstance.dateCreated}"/></td>

                            <td><g:formatDate date="${categoryInstance.lastUpdated}"/></td>
                            <td class="tdright"><b><g:formatNumber number="${categoryInstance?.sold}" format="0.##"/> €</b></td>
                            <td class="tdcenter">
                                <g:link title="Afficher les détails" data-toggle="modal" data-target="#modalWindow_show" action="show" id="${categoryInstance.id}"><img
                                        src="${resource(dir: 'img', file: 'details.png')}"/></g:link>
                                <g:link title="Editer" action="edit" id="${categoryInstance.id}"><img src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                                <g:link title="Opérations pour cette catégorie" action="operations" id="${categoryInstance.id}"><img
                                        src="${resource(dir: 'img', file: 'operation.png')}"/></g:link>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination text-right">
                    <g:paginate total="${categoryInstanceTotal}"/>
                </div>

            </div>
        </div>
    </div>
</div>

<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'une catégorie</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>
</body>
</html>
