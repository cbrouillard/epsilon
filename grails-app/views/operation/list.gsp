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
<%@ page import="com.headbangers.epsilon.Operation" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'operation.label', default: 'Operation')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <h1>Opérations <small>${selected?.getNameAndSold()}</small>
                <g:if test="${selected?.bank?.url}">
                    <a class="bank btn" href="${selected?.bank?.url}"><img src="${resource(dir: 'img', file: 'bank.png')}" alt=">"/> Site de la banque</a>
                </g:if>
            </h1>
            <hr/>
        </div>
    </div>

    <g:if test="${flash.message}">
        <div class="row">
            <div class="span12">
                <div class="alert alert-info">${flash.message}</div>
            </div>
        </div>
    </g:if>

    <div class="row">

        <div class="span9">
            <div class="around-border">

                <g:if test="${selected}">
                    <div id="register">

                        <g:render template="register"/>

                    </div>
                </g:if>
                <g:else>
                    <h1 class="red">Aucun compte enregistré.</h1>
                    <ul>
                        <li><g:link controller="bank" action="create"><img src="${resource(dir: 'img', file: 'bank.png')}"
                                                                           alt=">"/> Créer un nouvel établissement</g:link>
                        </li>
                        <li><g:link controller="account" action="create"><img src="${resource(dir: 'img', file: 'account.png')}"
                                                                              alt=">"/> Créer un nouveau compte</g:link>
                        </li>
                    </ul>
                </g:else>

            </div>
        </div>

        <div class="span3">
            <div class="around-border">

                <g:hasErrors bean="${operationInstance}">
                    <div class="alert alert-info">
                        <g:renderErrors bean="${operationInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <g:render template="registeractions"/>

            </div>
        </div>
    </div>

</div>

<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'une opération</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>
</body>
</html>
