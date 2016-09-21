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
<g:if test="${tiers?.pinned}">
    <g:remoteLink  controller="tiers" action="unpinne" update="tiers${tiers?.id}-pinned" id="${tiers?.id}">
        <img src="${resource(dir:'img', file:'unpinne.png')}" alt="P" title="Stopper la surveillance"/>
    </g:remoteLink>
</g:if>
<g:else>
    <g:remoteLink  controller="tiers" action="pinne" update="tiers${tiers?.id}-pinned" id="${tiers?.id}">
        <img src="${resource(dir:'img', file:'pinne.png')}" alt="_" title="Surveiller ce tiers"/>
    </g:remoteLink>
</g:else>