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
<%@ page contentType="text/html" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mail"/>
    <title><g:message code="app.name"/></title>

</head>

<body>
<div class="body">
    <div class="in-body">

        <div id="mail">
            <img src="${assetPath(absolute: true, src: 'grails_logo.png')}"
               alt="Epsilon"/><br/>

            <g:message code="mail.scheduled.explanation"/>
            <ul>
                <g:set var="involvedAccounts" value="${new HashSet()}" />
                <g:each var="scheduled" in="${mail}">
                    <li>
                        <g:message code="mail.scheduled.description"
                                   args="[scheduled.type, scheduled.amount, scheduled.tiers.name]"/>
                        -
                            ${scheduled.accountFrom.name}
                            <% involvedAccounts.add(scheduled.accountFrom) %>
                    </li>
                </g:each>
            </ul>
            <br/><hr/>
            <g:message code="mail.scheduled.accounts.summary"/>
            <ul>
              <g:each var="account" in="${involvedAccounts}">
                <li>
                  <g:link absolute="true" controller="operation" action="list"
                          params="[account: account.id]">
                  ${account.nameAndSold} <img src="${assetPath(absolute: true, src: 'operation.png')}"
                       alt="Voir les opérations"/>
                     </g:link>
                </li>
              </g:each>
            </ul>
            <br/><hr/>

            <g:link controller="summary" absolute="true">
                <g:message code="epsilon.connect"/>
            </g:link>
        </div>

    </div>
</div>
</body>
</html>
