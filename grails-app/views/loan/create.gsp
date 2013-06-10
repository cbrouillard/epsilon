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

<%@ page import="com.headbangers.epsilon.Loan" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>

</head>

<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Créer un nouveau prêt</h1>

                <div class="alert alert-info">
                    Saisissez les détails de votre prêt.
                    Epsilon sait gérer deux sens:
                    <ul>
                        <li>vous êtes l'emprunteur : sélectionnez l'onglet "Je doit de l'argent"</li>
                        <li>vous êtes le prêteur : sélectionnez l'onglet "On me doit de l'argent"</li>
                    </ul>
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

                <g:hasErrors bean="${loanInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${loanInstance}" as="list"/>
                        <g:renderErrors bean="${scheduled}" as="list"/>
                    </div>
                </g:hasErrors>

                <div class="tabbable"><!-- Only required for left/right tabs -->
                    <ul class="nav nav-tabs">
                        <li class="${!tabToDisplay || tabToDisplay == 'metous' ? 'active' : ''}">
                            <a href="#metous" data-toggle="tab">Je doit de l'argent</a>
                        </li>
                        <li class="${tabToDisplay == 'ustome' ? 'active' : ''}">
                            <a href="#ustome" data-toggle="tab">On me doit de l'argent</a>
                        </li>
                    </ul>

                    <div class="tab-content">

                        <div class="tab-pane ${!tabToDisplay || tabToDisplay == 'metous' ? 'active' : ''}" id="metous">

                            <g:render template="createloan" model="[type: 'ME_TO_US']"/>

                        </div>

                        <div class="tab-pane ${tabToDisplay == 'ustome' ? 'active' : ''}" id="ustome">

                            <g:render template="createloan" model="[type: 'US_TO_ME']"/>

                        </div>


                    </div>

                </div>

            </div>
        </div>
    </div>

</div>
</body>
</html>
