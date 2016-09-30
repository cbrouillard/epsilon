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
<g:if test="${category?.pinned}">
    <g:remoteLink  controller="category" action="unpinne" update="category${category?.id}-pinned" id="${category?.id}">
        <img src="${resource(dir:'img', file:'unpinne.png')}" alt="P" title=""/>
    </g:remoteLink>
</g:if>
<g:else>
    <g:remoteLink  controller="category" action="pinne" update="category${category?.id}-pinned" id="${category?.id}">
        <img src="${resource(dir:'img', file:'pinne.png')}" alt="_" title="${message(code:'category.watch')}"/>
    </g:remoteLink>
</g:else>