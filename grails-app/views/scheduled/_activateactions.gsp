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