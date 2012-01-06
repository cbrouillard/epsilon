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
<g:if test="${person?.enabled}">
  <g:remoteLink title="Désactiver" controller="admin" action="disableuser" update="person${person?.id}-enable" id="${person?.id}">
    <img src="${resource(dir:'img', file:'online.png')}" alt="D"/>
  </g:remoteLink>
</g:if>
<g:else>
  <g:remoteLink title="Activer" controller="admin" action="enableuser" update="person${person?.id}-enable" id="${person?.id}">
    <img src="${resource(dir:'img', file:'offline.png')}" alt="E"/>
  </g:remoteLink>
</g:else>