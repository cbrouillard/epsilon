<g:if test="${scheduled?.active}">
  <g:remoteLink  controller="scheduled" action="deactivate" update="scheduled${scheduled?.id}-activation" id="${scheduled?.id}">
    <img src="${resource(dir:'img', file:'online.png')}" alt="P" title="Désactiver cette échéance : elle ne sera plus affichée ni traitée."/>
  </g:remoteLink>
</g:if>
<g:else>
  <g:remoteLink  controller="scheduled" action="activate" update="scheduled${scheduled?.id}-activation" id="${scheduled?.id}">
    <img src="${resource(dir:'img', file:'offline.png')}" alt="_" title="Activer cette échéance : elle sera de nouveau traitée et affichée."/>
  </g:remoteLink>
</g:else>