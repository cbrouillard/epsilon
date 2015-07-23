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
<%@ page import="java.text.SimpleDateFormat; grails.converters.JSON; com.headbangers.epsilon.OperationType; org.grails.plugins.google.visualization.formatter.BarFormatter; com.headbangers.epsilon.Operation" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'operation.label', default: 'Operation')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1>Opérations <small>${selected?.getNameAndSold()}</small>
        <g:if test="${selected?.bank?.url}">
            <a class="bank btn btn-default" href="${selected?.bank?.url}"><img
                    src="${resource(dir: 'img', file: 'bank.png')}"
                    alt=">"/> Site de la banque</a>
        </g:if>
    </h1>
    <hr/>
</div>

<g:if test="${flash.message}">
    <div class="col-sm-12">
        <div class="alert alert-info">${flash.message}</div>
    </div>
</g:if>

<div class="col-sm-12 col-md-9">
    <g:if test="${selected}">
        <div class="around-border">

            <div class="row">

                <div class="counter-shower col-xs-12 col-sm-6">

                    <div class="number">
                        <span class="label label-default">
                            <g:formatNumber number="${depense}"
                                            format="0.##"/> €
                        </span>
                    </div>

                    <div class="lbl">
                        Opérations à débit
                    </div>

                </div>

                <div class="counter-shower col-xs-12 col-sm-6">

                    <div class="number">
                        <span class="label label-default">
                            <g:formatNumber number="${revenu}"
                                            format="0.##"/> €
                        </span>
                    </div>

                    <div class="lbl">
                        Opérations à crédit
                    </div>

                </div>

            </div>

            <g:render template="/chart/situation" model="[account: selected, idChart: 'situation', byMonth: byMonth, futures:futures]"/>

        </div>
        <br/>

        <div class="around-border">
            <div id="register">
                <g:render template="register"/>
            </div>
        </div>

    </g:if>
    <g:else>
        <div class="around-border">
            <h1 class="red">Aucun compte enregistré.</h1>
            <ul>
                <li><g:link controller="bank" action="create"><img src="${resource(dir: 'img', file: 'bank.png')}"
                                                                   alt=">"/> Créer un nouvel établissement</g:link>
                </li>
                <li><g:link controller="account" action="create"><img
                        src="${resource(dir: 'img', file: 'account.png')}"
                        alt=">"/> Créer un nouveau compte</g:link>
                </li>
            </ul>
        </div>
    </g:else>

    <br/>
</div>

<div class="col-sm-12 col-md-3">

    <g:hasErrors bean="${operationInstance}">
        <div class="alert alert-info">
            <g:renderErrors bean="${operationInstance}" as="list"/>
        </div>
    </g:hasErrors>

    <g:render template="registeractions"/>

    <br/>

    <div class="around-border">
        <%
            def dataCol = [['string', 'category'], ['number', 'Montant']]
        %>
        <gvisualization:barCoreChart elementId="byMonthChart"
                                     columns="${dataCol}" data="${graphData}"
                                     legend="${[position: 'none', alignment: 'center']}"/>
        <div id="byMonthChart"
             style="width: 100%; margin: auto;display: block;background: transparent;"></div>

    </div>
</div>

<div class="col-sm-12 col-md-9">

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
