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
<%@ page import="com.headbangers.epsilon.Tiers" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'tiers.label', default: 'Tiers')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Liste des tiers <small>Les personnes avec qui vous traitez.</small> <g:link controller="tiers" action="create" class="btn"><img
                        src="${resource(dir: 'img', file: 'tiers.png')}"
                        alt=">"/> Créer un nouveau tiers</g:link></h1>

                <div class="alert alert-info">
                    Les tiers sont les personnes (physiques ou morales) avec lesquelles vous échangez de l'argent.<br/>
                    Tout comme pour les catégories, il est inutile d'enregistrer toutes les personnes que vous connaissez:
                    Epsilon les intégrera au fur et à mesure de vos opérations.
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
                        <g:sortableColumn property="name" title="${message(code: 'tiers.name.label', default: 'Name')}"/>

                        <g:sortableColumn property="description" title="${message(code: 'tiers.description.label', default: 'Description')}"/>

                        <g:sortableColumn property="dateCreated" title="${message(code: 'tiers.dateCreated.label', default: 'Date Created')}"/>

                        <g:sortableColumn property="lastUpdated" title="${message(code: 'tiers.lastUpdated.label', default: 'Last Updated')}"/>

                        <th>Solde</th>

                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tiersInstanceList}" status="i" var="tiersInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td>${fieldValue(bean: tiersInstance, field: "name")}</td>

                            <td>${fieldValue(bean: tiersInstance, field: "description")}</td>

                            <td><g:formatDate date="${tiersInstance.dateCreated}"/></td>

                            <td><g:formatDate date="${tiersInstance.lastUpdated}"/></td>
                            <td class="tdright"><b><g:formatNumber number="${tiersInstance.sold}" format="0.##"/> €</b></td>
                            <td class="tdcenter">
                                <g:link title="Afficher les détails" data-toggle="modal" data-target="#modalWindow_show" action="show" id="${tiersInstance.id}"><img
                                        src="${resource(dir: 'img', file: 'details.png')}"/></g:link>
                                <g:link title="Editer" action="edit" id="${tiersInstance.id}"><img src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                                <g:link title="Opérations pour ce tiers" action="operations" id="${tiersInstance.id}"><img
                                        src="${resource(dir: 'img', file: 'operation.png')}"/></g:link>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination text-right">
                    <g:paginate total="${tiersInstanceTotal}"/>
                </div>

            </div>
        </div>
    </div>

</div>


<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'un tiers</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>
</body>
</html>
