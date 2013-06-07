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
<%@ page import="com.headbangers.epsilon.Budget" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Liste des budgets <small>Maitrise des dépenses.</small> <g:link controller="budget" action="create" class="btn"><img
                        src="${resource(dir: 'img', file: 'coins.png')}"
                        alt=">"/> Créer un nouveau budget</g:link></h1>

                <div class="alert alert-info">
                    Les budgets permettent de gérer des plafonds de dépenses sur certaines catégories.<br/><br/>
                    Chaque "budget" est "branché" sur une ou plusieurs catégories de dépenses. Lorsqu'un retrait
                    est enregistré avec l'une des catégories affectée à un budget, ce dernier voit son "montant
                    utilisé" augmenter.<br/><br/>
                    Tant que le budget est respecté, la valeur du "montant utilisé" s'affichera en <font style="color:green;">VERT</font><br/>
                    Si vous flirtez avec la valeur maximale, alors l'affichage se notera en <font style="color:orange;">ORANGE</font><br/>
                    Enfin, en cas de non respect de votre budget, l'affichage sera sévèrement colorié en <font
                        style="color:red; background-color: #000;">ROUGE SUR FOND NOIR</font>
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
                        <g:sortableColumn property="name" title="${message(code: 'budget.name.label', default: 'Name')}"/>
                        <th>Montant utilisé</th>
                        <g:sortableColumn property="amount" title="${message(code: 'budget.amount.label', default: 'Amount')}"/>
                        <th><g:message code="budget.categories.label" default="Categories"/></th>
                        <g:sortableColumn property="note" title="${message(code: 'budget.note.label', default: 'Note')}"/>
                        <g:sortableColumn property="lastUpdated" title="${message(code: 'budget.lastUpdated.label', default: 'Last Updated')}"/>
                        <th>Actions</th>
                        <g:sortableColumn property="active" title="${message(code: 'budget.active.label', default: 'Active')}"/>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${budgetInstanceList}" status="i" var="budgetInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td>${fieldValue(bean: budgetInstance, field: "name")}</td>

                            <g:set var="currentSold" value="${budgetInstance.currentMonthOperationsSum}"/>

                            <g:if test="${currentSold < budgetInstance.amount}">
                                <td class="budget-OK tdright">
                            </g:if>
                            <g:elseif test="${currentSold >= budgetInstance.amount - 1 && currentSold <= budgetInstance.amount + 1}">
                                <td class="budget-REACHED tdright">
                            </g:elseif>
                            <g:elseif test="${currentSold > budgetInstance.amount}">
                                <td class="budget-KO tdright">
                            </g:elseif>
                            <g:else>
                                <td class="budget tdright">
                            </g:else>
                            <g:formatNumber number="${currentSold}" format="0.##" /> €</td>

                            <td class="tdright"><b>${fieldValue(bean: budgetInstance, field: "amount")} €</b></td>
                            <td>
                                <ul>
                                    <g:each in="${budgetInstance.attachedCategories}" status="c" var="category">
                                        <li>${category.name}</li>
                                    </g:each>
                                </ul>
                            </td>
                            <td class="limitedSize">${fieldValue(bean: budgetInstance, field: "note")}</td>
                            <td><g:formatDate date="${budgetInstance.lastUpdated}"/></td>
                            <td class="tdcenter">
                                <g:link title="Afficher les détails" action="show" id="${budgetInstance.id}" data-toggle="modal"
                                        data-target="#modalWindow_show"><img
                                        src="${resource(dir: 'img', file: 'details.png')}" alt="Détails"/></g:link>
                                <g:link title="Editer" action="edit" id="${budgetInstance.id}"><img src="${resource(dir: 'img', file: 'edit.png')}"
                                                                                                    alt="Editer"/></g:link>
                                <g:link title="Afficher le registre" controller="budget" action="operations" params="[budget: budgetInstance.id]"><img
                                        src="${resource(dir: 'img', file: 'operation.png')}"/></g:link>
                            </td>
                            <td class="tdcenter">
                                <div id="budget${budgetInstance.id}-activation">
                                    <g:render template="activateactions" model="[budget: budgetInstance]"/>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination text-right">
                    <g:paginate total="${budgetInstanceTotal}"/>
                </div>

            </div>
        </div>
    </div>

</div>

<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'un budget</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>
</body>
</html>
