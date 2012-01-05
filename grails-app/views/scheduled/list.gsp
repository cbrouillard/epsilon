
<%@ page import="com.headbangers.epsilon.Scheduled" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'scheduled.label', default: 'Scheduled')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des échéances</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouvelle échéance</g:link></span>
        </div>
        <div class="body">
            <h1>Liste des échéances</h1>
            
            <div class="help">
              Les échéances sont des opérations récurrentes qui sont exécutées une seule fois par mois.<br/>
              Il peut s'agir par exemple du dépôt de salaire ou encore du paiement d'un crédit.<br/><br/>
              Une échéance peut être automatique ou manuelle.<br/>
              En mode automatique, l'échéance est appliquée toute seule à la date indiquée: vous n'avez rien à faire.<br/>
              En mode manuel, l'échéance est affichée sur la page d'accueil : un bouton permet de l'activer, un autre de l'ignorer pour le mois en cours.<br/><br/>
              Une échéance peut également être active ou inactive.<br/>
              Une échéance inactive est considérée comme supprimée et est simplement ignorée par le système.
            </div>
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="name" title="${message(code: 'scheduled.name.label', default: 'Name')}" />                            
                            <th><g:message code="scheduled.account.label" default="Account" /></th>
                            <th><g:message code="scheduled.tiers.label" default="Tiers" /></th>
                            <g:sortableColumn property="amount" title="${message(code: 'scheduled.amount.label', default: 'Amount')}" />
                            <g:sortableColumn property="dateApplication" title="${message(code: 'scheduled.dateApplication.label', default: 'Date Application')}" />

                            <g:sortableColumn property="type" title="${message(code: 'scheduled.type.label', default: 'Type')}" />
                            <g:sortableColumn property="automatic" title="${message(code: 'scheduled.automatic.label', default: 'Automatic')}" />
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
                            <td  class="tdright"><g:formatNumber number="${scheduledInstance?.amount}" format="0.##" /> €</td>
                            <td><g:formatDate date="${scheduledInstance.dateApplication}" /></td>

                            <td>${fieldValue(bean: scheduledInstance, field: "type")}</td>
                            <td><g:formatBoolean boolean="${scheduledInstance?.automatic}" /></td>
                            <td class="center">
                              <g:link title="Afficher les détails" action="show" id="${scheduledInstance.id}" class="popup" rel="popup"><img src="${resource(dir:'img', file:'details.png')}" alt="Détails"/></g:link>
                              <g:link title="Editer" action="edit" id="${scheduledInstance.id}"><img src="${resource(dir:'img', file:'edit.png')}" alt="Editer"/></g:link>
                            </td>
                            <td class="center">
                              <div id="scheduled${scheduledInstance.id}-activation">
                                <g:render template="activateactions" model="[scheduled:scheduledInstance]"/>
                              </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${scheduledInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
