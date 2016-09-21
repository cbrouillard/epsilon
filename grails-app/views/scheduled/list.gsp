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

<div class="col-sm-12">
    <h1>Liste des échéances <small>Opérations mensuelles et récurrentes.</small> <g:link controller="scheduled"
                                                                                         action="create"
                                                                                         class="btn btn-success"><img
                src="${resource(dir: 'img', file: 'echeancy.png')}"
                alt=">"/> Créer une nouvelle échéance</g:link></h1>

    <div class="row">
        <div class="col-sm-7">
            <div class="alert alert-info">
                Les échéances sont des opérations récurrentes qui sont exécutées une seule fois par mois. Il peut s'agir par exemple du dépôt de salaire
                ou encore du paiement d'un crédit.<br/><br/>
                Une échéance peut être automatique ou manuelle.
                <ul>
                    <li>En mode automatique, l'échéance est appliquée toute seule à la date indiquée: vous n'avez rien à faire.</li>
                    <li>En mode manuel, l'échéance est affichée sur la page d'accueil : un bouton permet de l'activer, un autre de l'ignorer pour le mois
                    en cours.</li>
                </ul><br/>
                Une échéance peut également être active ou inactive: une échéance inactive est considérée comme supprimée et est simplement ignorée par le
                système.
            </div>
        </div>

        <div class="col-sm-5">
            <div class="around-border">
                <div class="row">

                    <div class="counter-shower col-xs-12 col-sm-6">

                        <div class="number">
                            <span class="label label-${depense > revenus ? 'danger' : 'default'}">
                                <g:formatNumber number="${depense}"
                                                format="###,###.##"/> €
                            </span>
                        </div>

                        <div class="lbl">
                            Dépenses prévues
                        </div>

                    </div>

                    <div class="counter-shower col-xs-12 col-sm-6">

                        <div class="number">
                            <span class="label label-default">
                                <g:formatNumber number="${revenus}"
                                                format="###,###.##"/> €
                            </span>
                        </div>

                        <div class="lbl">
                            Revenus prévus
                        </div>

                    </div>

                </div>

                <div class="clearfix">&nbsp;</div>

                <div class="row">

                    <div class="counter-shower col-xs-12 col-sm-6">

                        <div class="number">
                            <span class="label label-default">
                                <g:formatNumber number="${seuil}"
                                                format="###,###.##"/> €
                            </span>
                        </div>

                        <div class="lbl">
                            Seuil optimal de dépenses / mois<br/>
                            <small>(dépenses + budgets actifs)</small>
                        </div>

                    </div>

                    <div class="counter-shower col-xs-12 col-sm-6">

                        <div class="number">
                            <g:set var="potentielEpargne" value="${revenus - seuil}"/>
                            <span class="label label-${potentielEpargne <= 0 ? 'warning' : 'success'}">
                                <g:formatNumber number="${potentielEpargne}"
                                                format="###,###.##"/> €
                            </span>
                        </div>

                        <div class="lbl">
                            Potentiel épargne<br/>
                            <small>(ce qui peut être mis de côté)</small>
                        </div>

                    </div>

                </div>

            </div>
        </div>

    </div>

    <hr/>
</div>


<div class="col-sm-12">
    <div class="around-border">

        <div class="text-right pull-right">
            <g:render template="/generic/search"/>
        </div>

        <g:render template="/generic/listsize"/>
        <div class="clearfix"></div>

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>



        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <g:sortableColumn property="name"
                                      title="${message(code: 'scheduled.name.label', default: 'Name')}"/>
                    <th><g:message code="scheduled.account.label" default="Account"/></th>
                    <th><g:message code="scheduled.tiers.label" default="Tiers"/></th>

                    <g:sortableColumn property="type"
                                      title="${message(code: 'scheduled.type.label', default: 'Type')}"/>
                    <g:sortableColumn property="automatic"
                                      title="${message(code: 'scheduled.automatic.label', default: 'Automatic')}"/>
                    <g:sortableColumn property="dateApplication"
                                      title="${message(code: 'scheduled.dateApplication.label', default: 'Date Application')}"/>
                    <g:sortableColumn property="amount" class="text-right"
                                      title="${message(code: 'scheduled.amount.label', default: 'Amount')}"/>
                    <th class="text-center">Active ?</th>
                    <th class="text-right">Actions</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${scheduledInstanceList}" status="i" var="scheduledInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        <td>${fieldValue(bean: scheduledInstance, field: "name")}</td>
                        <td>${fieldValue(bean: scheduledInstance, field: "accountFrom.name")}</td>
                        <td>${fieldValue(bean: scheduledInstance, field: "tiers.name")}</td>


                        <td>${fieldValue(bean: scheduledInstance, field: "type")}</td>
                        <td><g:formatBoolean boolean="${scheduledInstance?.automatic}"/>
                            <g:if test="${scheduledInstance?.automatic}">
                                <small>(${scheduledInstance?.cronExpression ? scheduledInstance.cronName : message(code: 'prebuiltcronexpression.SAME_DAY_NEXT_MONTH')})</small>
                            </g:if>
                        </td>
                        <td>
                            <g:if test="${scheduledInstance.automatic}">
                            <span data-toggle="tooltip" data-placement="bottom" title="puis ${scheduledInstance.nextDates*.format("dd-MM-yy")}, etc ...">
                                <g:formatDate date="${scheduledInstance.dateApplication}"/>
                            </span>
                            </g:if>
                            <g:else>
                                <g:formatDate date="${scheduledInstance.dateApplication}"/>
                            </g:else>
                        </td>
                        <td class="tdright"><b><g:formatNumber number="${scheduledInstance?.amount}"
                                                               format="###,###.##"/> €</b></td>
                        <td class="tdcenter">
                            <div id="scheduled${scheduledInstance.id}-activation">
                                <g:render template="activateactions" model="[scheduled: scheduledInstance]"/>
                            </div>
                        </td>
                        <td class="text-right">
                            <g:link title="Afficher les détails" action="show" id="${scheduledInstance.id}"
                                    data-toggle="modal"
                                    data-target="#modalWindow_show"><img
                                    src="${resource(dir: 'img', file: 'details.png')}" alt="Détails"/></g:link>
                            <g:link title="Editer" action="edit" id="${scheduledInstance.id}"><img
                                    src="${resource(dir: 'img', file: 'edit.png')}"
                                    alt="Editer"/></g:link>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="pagination pull-right">
            <g:paginate total="${scheduledInstanceTotal}"/>
        </div>

        <div class="clearfix">&nbsp;</div>

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
