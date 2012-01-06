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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>

  <resource:tabView skin="custom_tab"/>
  <resource:autoComplete skin="default" />

</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des prêts</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau prêt</g:link></span>
  </div>
  <div class="body">
    <h1>Créer un nouveau prêt</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${loanInstance}">
      <div class="errors">
        <g:renderErrors bean="${loanInstance}" as="list" />
        <g:renderErrors bean="${scheduled}" as="list" />
      </div>
    </g:hasErrors>


    <richui:tabView id="tabView">
      <richui:tabLabels>
        <g:if test="${!tabToDisplay || tabToDisplay=='metous'}">
          <richui:tabLabel selected="true" title="Je doit de l'argent" />
        </g:if><g:else><richui:tabLabel  title="Je doit de l'argent" /></g:else>
        <g:if test="${tabToDisplay=='ustome'}">
          <richui:tabLabel selected="true" title="On me doit de l'argent" />
        </g:if><g:else><richui:tabLabel  title="On me doit de l'argent" /></g:else>

      </richui:tabLabels>
      <richui:tabContents>

        <richui:tabContent>
          <g:render template="createloan" model="[type:'ME_TO_US']" />
        </richui:tabContent>

        <richui:tabContent>
          <g:render template="createloan" model="[type:'US_TO_ME']" />
        </richui:tabContent>

      </richui:tabContents>
    </richui:tabView>

  </div>
</body>
</html>
