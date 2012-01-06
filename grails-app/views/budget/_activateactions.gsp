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