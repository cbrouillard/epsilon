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
    <a href="#" title="Désactiver"
       onclick="ajaxPostLink('${createLink(controller:'category', action:'unpinne', id:category?.id)}', 'category${category?.id}-pinned');">
        <img src="${resource(dir:'img', file:'unpinne.png')}" alt="P" title="${message(code:'category.unwatch')}"/>
    </a>
</g:if>
<g:else>
    <a href="#" title="Désactiver"
       onclick="ajaxPostLink('${createLink(controller:'category', action:'pinne', id:category?.id)}', 'category${category?.id}-pinned');">
        <img src="${resource(dir:'img', file:'pinne.png')}" alt="_" title="${message(code:'category.watch')}"/>
    </a>
</g:else>