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
                    <g:set var="linked" value="${Account.findByDocument(document)}"/>
                </g:if>

                <g:if test="${linked}">
                    <g:render template="linkdescriptor" model="[linked:linked]"/>
                </g:if>
                <g:else>
                    <i><g:message code="document.${document.type.toString().toLowerCase()}.not.linked"/></i>
                </g:else>

            </li>

            <li class="list-group-item">
                <div class="btn-group btn-group-sm" role="group" aria-label="...">
                    <g:link controller="document" action="download" id="${document.id}" class="btn btn-success">
                        <img src="${resource(dir: 'img', file: 'invoice.png')}"/> <g:message code="document.download"/>
                    </g:link>
                    <g:link controller="document" id="${document.id}" action="linkto" class="btn btn-default">
                        <img src="${resource(dir: 'img', file: 'link.png')}"
                             data-toggle="tooltip" data-placement="bottom"
                             title="${message(code: "document.${document.type.toString().toLowerCase()}.linkto")}"/> Lier
                    </g:link>
                </div>
            </li>

        </ul>

    </div>
</div>