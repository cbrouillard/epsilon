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
    <title><g:message code="default.create.label" args="[entityName]"/></title>

</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Créer une nouvelle échéance</h1>
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

                <g:hasErrors bean="${scheduledInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${scheduledInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <div class="tabbable"><!-- Only required for left/right tabs -->
                    <ul class="nav nav-tabs">
                        <li class="${tabToDisplay == 'depot' ? 'active' : ''}">
                            <a href="#depot" data-toggle="tab">Dépôt</a>
                        </li>
                        <li class="${tabToDisplay == 'virement' ? 'active' : ''}">
                            <a href="#virement" data-toggle="tab">Virement</a>
                        </li>
                        <li class="${!tabToDisplay || tabToDisplay == 'facture' ? 'active' : ''}">
                            <a href="#facture" data-toggle="tab">Facture</a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane ${tabToDisplay == 'depot' ? 'active' : ''}" id="depot">

                            <g:render template="createform" model="[type: 'depot', selected: selected]"/>

                        </div>

                        <div class="tab-pane ${tabToDisplay == 'virement' ? 'active' : ''}" id="virement">

                            <g:render template="createvirement" model="[selected: selected]"/>

                        </div>

                        <div class="tab-pane ${!tabToDisplay || tabToDisplay == 'facture' ? 'active' : ''}" id="facture">

                            <g:render template="createform" model="[type: 'facture', selected: selected]"/>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</div>
</body>
</html>
