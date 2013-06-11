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
<%@ page import="com.headbangers.epsilon.Scheduled" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'scheduled.label', default: 'Scheduled')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Liste des échéances <small>Opérations mensuelles et récurrentes.</small> <g:link controller="scheduled" action="create" class="btn"><img
                        src="${resource(dir: 'img', file: 'echeancy.png')}"
                        alt=">"/> Créer une nouvelle échéance</g:link></h1>

                <div class="alert alert-info">
                    Les échéances sont des opérations récurrentes qui sont exécutées une seule fois par mois. Il peut s'agir par exemple du dépôt de salaire
                    ou encore du paiement d'un crédit.<br/><br/>
                    Une échéance peut être automatique ou manuelle.
                    <ul>
                        <li>En mode automatique, l'échéance est appliquée toute seule à la date indiquée: vous n'avez rien à faire.</li>
                        <li>En mode manuel, l'échéance est affichée sur la page d'accueil : un bouton permet de l'activer, un autre de l'ignorer pour le mois
                        en cours.</li>
                    </ul>
                    Une échéance peut également être active ou inactive: une échéance inactive est considérée comme supprimée et est simplement ignorée par le
                    système.
                </div>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">
                <g:if test="${flash.message}">
                    <div class="alert alert-info">${flash.message}</div>
                </g:if>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <g:sortableColumn property="name" title="${message(code: 'scheduled.name.label', default: 'Name')}"/>
                        <th><g:message code="scheduled.account.label" default="Account"/></th>
                        <th><g:message code="scheduled.tiers.label" default="Tiers"/></th>
                        <g:sortableColumn property="amount" title="${message(code: 'scheduled.amount.label', default: 'Amount')}"/>
                        <g:sortableColumn property="dateApplication" title="${message(code: 'scheduled.dateApplication.label', default: 'Date Application')}"/>

                        <g:sortableColumn property="type" title="${message(code: 'scheduled.type.label', default: 'Type')}"/>
                        <g:sortableColumn property="automatic" title="${message(code: 'scheduled.automatic.label', default: 'Automatic')}"/>
                        <th>Actions</th>
                        <th>Active ?</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${scheduledInstanceList}" status="i" var="scheduledInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${fieldValue(bean: scheduledInstance, field: "name")}</td>
                            <td>${fieldValue(bean: scheduledInstance, field: "accountFrom.name")}</td>
                            <td>${fieldValue(bean: scheduledInstance, field: "tiers.name")}</td>
                            <td class="tdright"><b><g:formatNumber number="${scheduledInstance?.amount}" format="0.##"/> €</b></td>
                            <td><g:formatDate date="${scheduledInstance.dateApplication}"/></td>

                            <td>${fieldValue(bean: scheduledInstance, field: "type")}</td>
                            <td><g:formatBoolean boolean="${scheduledInstance?.automatic}"/></td>
                            <td class="tdcenter">
                                <g:link title="Afficher les détails" action="show" id="${scheduledInstance.id}" data-toggle="modal"
                                        data-target="#modalWindow_show"><img
                                        src="${resource(dir: 'img', file: 'details.png')}" alt="Détails"/></g:link>
                                <g:link title="Editer" action="edit" id="${scheduledInstance.id}"><img src="${resource(dir: 'img', file: 'edit.png')}"
                                                                                                       alt="Editer"/></g:link>
                            </td>
                            <td class="tdcenter">
                                <div id="scheduled${scheduledInstance.id}-activation">
                                    <g:render template="activateactions" model="[scheduled: scheduledInstance]"/>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination text-right">
                    <g:paginate total="${scheduledInstanceTotal}"/>
                </div>

            </div>
        </div>
    </div>

</div>

<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'une échéance</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>

</body>
</html>
