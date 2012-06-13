
<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'wish.label', default: 'Wish')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-wish" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-wish" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list wish">
			
				<g:if test="${wishInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="wish.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${wishInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="wish.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${wishInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="wish.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${wishInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.webShopUrl}">
				<li class="fieldcontain">
					<span id="webShopUrl-label" class="property-label"><g:message code="wish.webShopUrl.label" default="Web Shop Url" /></span>
					
						<span class="property-value" aria-labelledby="webShopUrl-label"><g:fieldValue bean="${wishInstance}" field="webShopUrl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.boughtDate}">
				<li class="fieldcontain">
					<span id="boughtDate-label" class="property-label"><g:message code="wish.boughtDate.label" default="Bought Date" /></span>
					
						<span class="property-value" aria-labelledby="boughtDate-label"><g:formatDate date="${wishInstance?.boughtDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.previsionBuy}">
				<li class="fieldcontain">
					<span id="previsionBuy-label" class="property-label"><g:message code="wish.previsionBuy.label" default="Prevision Buy" /></span>
					
						<span class="property-value" aria-labelledby="previsionBuy-label"><g:formatDate date="${wishInstance?.previsionBuy}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.account}">
				<li class="fieldcontain">
					<span id="account-label" class="property-label"><g:message code="wish.account.label" default="Account" /></span>
					
						<span class="property-value" aria-labelledby="account-label"><g:link controller="account" action="show" id="${wishInstance?.account?.id}">${wishInstance?.account?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.bought}">
				<li class="fieldcontain">
					<span id="bought-label" class="property-label"><g:message code="wish.bought.label" default="Bought" /></span>
					
						<span class="property-value" aria-labelledby="bought-label"><g:formatBoolean boolean="${wishInstance?.bought}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="wish.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${wishInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="wish.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${wishInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${wishInstance?.owner}">
				<li class="fieldcontain">
					<span id="owner-label" class="property-label"><g:message code="wish.owner.label" default="Owner" /></span>
					
						<span class="property-value" aria-labelledby="owner-label"><g:link controller="person" action="show" id="${wishInstance?.owner?.id}">${wishInstance?.owner?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${wishInstance?.id}" />
					<g:link class="edit" action="edit" id="${wishInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
