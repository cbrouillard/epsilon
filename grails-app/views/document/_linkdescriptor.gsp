<%@ page import="com.headbangers.epsilon.Operation" %>
<span class="pull-right" >
    <g:link controller="${document.type.controllerName}" action="edit" id="${linked.id}">
        <img src="${resource(dir: 'img', file: 'edit.png')}"/>
    </g:link>
</span>
<ul class="list-inline">

    <g:if test="${linked instanceof com.headbangers.epsilon.Operation}">
        <g:set var="operation" value="${(com.headbangers.epsilon.Operation) linked}"/>
        <li><g:formatDate date="${operation.dateApplication}"/></li>
        <li>${operation.category.name} - ${operation.tiers.name}</li>
        <li><g:formatNumber number="${operation?.amount}" format="###,###.##"/> €</li>
    </g:if>

</ul>

<div class="clearfix"></div>