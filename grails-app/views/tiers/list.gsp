
<%@ page import="com.headbangers.epsilon.Tiers" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tiers.label', default: 'Tiers')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

        <resource:autoComplete skin="default" />
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des tiers</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouveau tiers</g:link></span>
        </div>
        <div class="body">
            <h1>Liste des tiers</h1>

            <div class="help">
              Les tiers sont les personnes (physiques ou morales) avec lesquelles vous échangez de l'argent.<br/><br/>
              Tout comme pour les catégories, il est inutile d'enregistrer toutes les personnes que vous connaissez:<br/>
              Epsilon les intégrera au fur et à mesure de vos opérations.
            </div>
            
            <g:render template="/generic/search"/>

            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="name" title="${message(code: 'tiers.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'tiers.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'tiers.dateCreated.label', default: 'Date Created')}" />
                        
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'tiers.lastUpdated.label', default: 'Last Updated')}" />

                            <th>Solde</th>

                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tiersInstanceList}" status="i" var="tiersInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean: tiersInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: tiersInstance, field: "description")}</td>
                        
                            <td><g:formatDate date="${tiersInstance.dateCreated}" /></td>
                        
                            <td><g:formatDate date="${tiersInstance.lastUpdated}" /></td>
                            <td class="tdright"><g:formatNumber number="${tiersInstance.sold}" format="0.##" /> €</td>
                            <td class="center">
                              <g:link title="Afficher les détails" class="popup" action="show" id="${tiersInstance.id}"><img src="${resource(dir:'img', file:'details.png')}"/></g:link>
                              <g:link title="Editer" action="edit" id="${tiersInstance.id}"><img src="${resource(dir:'img', file:'edit.png')}"/></g:link>
                              <g:link title="Opérations pour ce tiers" action="operations" id="${tiersInstance.id}"><img src="${resource(dir:'img', file:'operation.png')}"/></g:link>
                              <g:link action="operations" id="${tiersInstance.id}"><img src="${resource(dir:'img', file:'stats.png')}" alt="|||"/></g:link>
                            </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tiersInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
