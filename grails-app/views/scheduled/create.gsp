
<%@ page import="com.headbangers.epsilon.Scheduled" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'scheduled.label', default: 'Scheduled')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>

  <resource:tabView skin="custom_tab"/>
  <resource:autoComplete skin="default" />

</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des échéances</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouvelle échéance</g:link></span>
  </div>
  <div class="body">
    <h1>Créer une échéance</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${scheduledInstance}">
      <div class="errors">
        <g:renderErrors bean="${scheduledInstance}" as="list" />
      </div>
    </g:hasErrors>


        <richui:tabView id="tabView">
          <richui:tabLabels>
            <g:if test="${tabToDisplay=='depot'}">
            <richui:tabLabel selected="true" title="Dépôt" />
            </g:if><g:else><richui:tabLabel  title="Dépôt" /></g:else>
            <g:if test="${tabToDisplay=='virement'}">
            <richui:tabLabel selected="true" title="Virement" />
            </g:if><g:else><richui:tabLabel  title="Virement" /></g:else>
            <g:if test="${!tabToDisplay || tabToDisplay=='facture'}">
            <richui:tabLabel selected="true" title="Facture" />
            </g:if><g:else><richui:tabLabel  title="Facture" /></g:else>

          </richui:tabLabels>
          <richui:tabContents>

            <richui:tabContent>
              <g:render template="createform" model="[type:'depot', selected:selected]" />
            </richui:tabContent>

            <richui:tabContent>
              <g:render template="createvirement" model="[selected:selected]" />
            </richui:tabContent>

            <richui:tabContent>
              <g:render template="createform" model="[type:'facture', selected:selected]" />
            </richui:tabContent>

          </richui:tabContents>
        </richui:tabView>

      
  </div>
</body>
</html>
