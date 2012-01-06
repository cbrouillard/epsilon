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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'operation.label', default: 'Operation')}" />
  <title><g:message code="default.list.label" args="[entityName]" /></title>

  <resource:tabView skin="custom_tab"/>
  <resource:autoComplete skin="default" />

</head>
<body>
  
  <div class="undernav">   
    
    <g:form action="list" method="get" >
      <span class="menuButton special"><a class="operation" href="#write-operation">Saisir une opération</a></span>
      
      <g:if test="${selected}">
      <label for="account">Changer de compte:</label>
      <g:select optionValue="${{it.name+' = '+formatNumber('number':it.getSold(), 'format':'0.##')+'€'}}" name="account" from="${accounts}" optionKey="id" value="${selected?.id}" onChange="this.form.submit();"/>
      </g:if>
      
      <g:if test="${selected?.bank?.url}">
          <span class="menuButton"><a class="bank" href="${selected?.bank?.url}">Site de la banque</a></span>
        </g:if>
      
      
    </g:form>
    
  </div>

  <div class="body">
    
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>

    <g:if test="${selected}">
      <div id="register">
        
        <g:render template="register"/>
        

      </div>
    </g:if><g:else>
      <h1 class="red">Aucun compte enregistré.</h1>
      <ul>
        <li><g:link controller="bank" action="create"><img src="${resource(dir:'img', file:'bank.png')}" alt=">"/> Créer un nouvel établissement</g:link></li>
        <li><g:link controller="account" action="create"><img src="${resource(dir:'img', file:'account.png')}" alt=">"/> Créer un nouveau compte</g:link></li>
      </ul>
    </g:else>
  </div>
</body>
</html>
