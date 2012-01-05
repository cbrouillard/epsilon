<g:if test="${operation?.pointed}">
  <g:remoteLink  controller="operation" action="unpoint" update="operation${operation?.id}-point" id="${operation?.id}">
    <img src="${resource(dir:'img', file:'online.png')}" alt="P" title="Enlever le pointage sur cette opération"/>
  </g:remoteLink>
</g:if>
<g:else>
  <g:remoteLink  controller="operation" action="point" update="operation${operation?.id}-point" id="${operation?.id}">
    <img src="${resource(dir:'img', file:'offline.png')}" alt="_" title="Pointer cette opération"/>
  </g:remoteLink>
</g:else>