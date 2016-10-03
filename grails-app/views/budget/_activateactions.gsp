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
    <a href="#" title="Désactiver"
       onclick="ajaxPostLink('${createLink(controller:'budget', action:'deactivate', id:budget?.id)}', 'budget${budget?.id}-activation');">
        <img src="${resource(dir:'img', file:'online.png')}" alt="P" title="${message(code:'budget.deactivate')}"/>
    </a>
</g:if>
<g:else>
    <a href="#" title="Activer"
       onclick="ajaxPostLink('${createLink(controller:'budget', action:'activate', id:budget?.id)}', 'budget${budget?.id}-activation');">
        <img src="${resource(dir:'img', file:'offline.png')}" alt="_" title="${message(code:'budget.activate')}"/>
    </a>
</g:else>