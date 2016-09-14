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
<%@ page import="com.headbangers.epsilon.Wish" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'wish.label', default: 'Wish')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1>Liste des futurs achats <small>Ce que vous désirez !</small> <g:link controller="wish" action="create"
                                                                             class="btn btn-success"><img
                src="${resource(dir: 'img', file: 'gift.png')}"
                alt=">"/> Créer un nouveau souhait</g:link></h1>

    <div class="alert alert-info">
        Voici la liste de vos futurs achats. Saisissez vos projets : Epsilon se charge de vous dire si toutes vos
        envies rentrent dans votre budget !
    </div>

    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        <div class="row">
            <g:each in="${wishInstanceList}" status="i" var="wishInstance">
                <div class="col-lg-3 col-md-5 col-sm-5">
                    <div class="thumbnail panel-default">
                        <div style="height: 200px;" class="wish-img">
                            <g:if test="${wishInstance.thumbnailUrl}">
                                <a href="${wishInstance.webShopUrl}" target="_blank">
                                    <img style="max-height: 200px;max-width: 200px;vertical-align: middle;"
                                         src="${wishInstance.thumbnailUrl}"/>
                                </a>
                            </g:if>
                            <g:else>
                                <g:link title="Editer" action="edit" id="${wishInstance.id}">
                                    <img style="max-height: 200px;max-width: 200px;"
                                         src="${resource(dir: 'img', file: 'no-image.png')}"/>
                                </g:link>
                            </g:else>
                        </div>

                        <div class="caption text-center">
                            <ul class="list-group">
                                <li class="list-group-item list-group-item-success"
                                    style=" word-wrap: break-word;height: 95px;">
                                    <strong>${fieldValue(bean: wishInstance, field: "name")}</strong>
                                </li>
                                <li class="list-group-item">
                                    ${fieldValue(bean: wishInstance, field: "price")} €
                                </li>
                                <g:if test="${wishInstance.webShopUrl}">
                                    <li class="list-group-item">
                                        <a href="${wishInstance.webShopUrl}" target="_blank">Lien boutique</a>
                                    </li>
                                </g:if>
                                <g:if test="${wishInstance.previsionBuy}">
                                    <li class="list-group-item">
                                        Date prévue pour l'achat : <g:formatDate date="${wishInstance.previsionBuy}"/>
                                    </li>
                                </g:if>
                                <g:if test="${wishInstance.boughtDate}">
                                    <li class="list-group-item">
                                        Date d'achat : <g:formatDate date="${wishInstance.boughtDate}"/>
                                    </li>
                                </g:if>
                                <g:if test="${wishInstance.description}">
                                    <li class="list-group-item">
                                        ${fieldValue(bean: wishInstance, field: "description")}
                                    </li>
                                </g:if>
                                <li class="list-group-item">
                                    <div class="btn-group btn-group-xs" role="group" aria-label="...">
                                        <g:link title="Afficher les détails" action="show" id="${wishInstance.id}"
                                                data-toggle="modal" data-target="#modalWindow_show" class="btn"><img
                                                src="${resource(dir: 'img', file: 'details.png')}"
                                                alt="Détails"/></g:link>
                                        <g:link title="Editer" action="edit" id="${wishInstance.id}" class="btn"><img
                                                src="${resource(dir: 'img', file: 'edit.png')}" alt="Editer"/></g:link>
                                        <g:link title="Acheter!" action="create_operation" id="${wishInstance.id}"
                                                class="btn"><img
                                                src="${resource(dir: 'img', file: 'buy.png')}" alt="Acheter!"/></g:link>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </g:each>
            <div class="clearfix"></div>
        </div>

        <div class="pagination pull-right">
            <g:paginate total="${wishInstanceTotal}"/>
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
