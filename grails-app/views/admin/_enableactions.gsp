<g:if test="${person?.enabled}">
  <g:remoteLink title="Désactiver" controller="admin" action="disableuser" update="person${person?.id}-enable" id="${person?.id}">
    <img src="${resource(dir:'img', file:'online.png')}" alt="D"/>
  </g:remoteLink>
</g:if>
<g:else>
  <g:remoteLink title=Activer" controller="admin" action="enableuser" update="person${person?.id}-enable" id="${person?.id}">
    <img src="${resource(dir:'img', file:'offline.png')}" alt="E"/>
  </g:remoteLink>
</g:else>