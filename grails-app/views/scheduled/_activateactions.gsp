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
    <img src="${resource(dir:'img', file:'online.png')}" alt="P" title="${message(code:'scheduled.deactivate')}"/>
  </g:remoteLink>
</g:if>
<g:else>
  <g:remoteLink  controller="scheduled" action="activate" update="scheduled${scheduled?.id}-activation" id="${scheduled?.id}">
    <img src="${resource(dir:'img', file:'offline.png')}" alt="_" title="${message(code:'scheduled.activate')}"/>
  </g:remoteLink>
</g:else>