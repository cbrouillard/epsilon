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
<%@ page import="com.headbangers.epsilon.Account; com.headbangers.epsilon.Bank; com.headbangers.epsilon.Operation" %>
<div>
    <div class="caption text-center">

        <ul class="list-group">
            <li class="list-group-item list-group-item-success" style="word-wrap: break-word;">
                <strong>${fieldValue(bean: document, field: "name")}</strong>
            </li>

            <li class="list-group-item ">
                <g:message code="document.type.${document.type.toString().toLowerCase()}"/>
            </li>

            <li class="list-group-item">
                Créé le : <g:formatDate date="${document.dateCreated}"/>
            </li>

            <li class="list-group-item">

                <g:if test="${document.type == com.headbangers.epsilon.Document.Type.INVOICE}">
                    <g:set var="linked" value="${Operation.findByDocument(document)}"/>
                </g:if>
                <g:if test="${document.type == com.headbangers.epsilon.Document.Type.BANK}">
                    <g:set var="linked" value="${Bank.findByDocument(document)}"/>
                </g:if>
                <g:if test="${document.type == com.headbangers.epsilon.Document.Type.ACCOUNT}">
                    <g:set var="linked" value="${accounts.find { it.documents.contains(document) }}"/>
                </g:if>
                <g:if test="${document.type == com.headbangers.epsilon.Document.Type.SALARY}">
                    <g:set var="linked" value="${Operation.findByDocument(document)}"/>
                </g:if>

                <g:if test="${linked}">
                    <g:render template="/document/linkdescriptor" model="[linked: linked]"/>
                </g:if>
                <g:else>
                    <i><g:message code="document.${document.type.toString().toLowerCase()}.not.linked"/></i>
                </g:else>

            </li>

            <li class="list-group-item">
                <div class="btn-group btn-group-sm" role="group" aria-label="...">
                    <g:link controller="document" action="download" id="${document.id}" class="btn btn-success">
                        <img src="${assetPath(src: 'invoice.png')}"/> <g:message code="document.download"/>
                    </g:link>
                    <g:link controller="document" id="${document.id}" action="linkto" class="btn btn-default"
                            data-toggle="tooltip" data-placement="bottom"
                            title="${message(code: "document.${document.type.toString().toLowerCase()}.linkto")}">
                        <img src="${assetPath(src: 'link.png')}"/> Lier
                    </g:link>
                </div>
            </li>

        </ul>

    </div>
</div>