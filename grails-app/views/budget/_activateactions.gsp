<g:if test="${budget?.active}">
  <g:remoteLink  controller="budget" action="deactivate" update="budget${budget?.id}-activation" id="${budget?.id}">
    <img src="${resource(dir:'img', file:'online.png')}" alt="P" title="Désactiver ce budget : il ne sera plus considéré comme actif."/>
  </g:remoteLink>
</g:if>
<g:else>
  <g:remoteLink  controller="budget" action="activate" update="budget${budget?.id}-activation" id="${budget?.id}">
    <img src="${resource(dir:'img', file:'offline.png')}" alt="_" title="Activer ce budget : il pourra à nouveau être utilisé."/>
  </g:remoteLink>
</g:else>