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