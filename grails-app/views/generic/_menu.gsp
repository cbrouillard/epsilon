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
<%@ page import="com.headbangers.epsilon.Account" %>
<ul class="nav navbar-nav">

    <li class="${controllerName == 'bank' || controllerName == 'account' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'bank.png')}"/> <g:message code="menu.bank"/> <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li class="dropdown-header"><g:message code="banks"/></li>
            <li>
                <g:link controller="bank" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/>
                    <g:message code="bank.list"/>
                </g:link>
            </li>
            <li>
                <g:link controller="bank" class="create" action="create"><img
                        src="${resource(dir: 'img', file: 'bank.png')}"/>
                    <g:message code="bank.create"/>
                </g:link>
            </li>
            <li class="divider"></li>
            <li class="dropdown-header"><g:message code="accounts"/></li>
            <li>
                <g:link controller="account" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/>
                    <g:message code="account.list"/>
                </g:link>
            </li>
            <li>
                <g:link controller="account" class="create" action="create"><img
                        src="${resource(dir: 'img', file: 'account.png')}"/>
                    <g:message code="account.create"/>
                </g:link>
            </li>
            <li class="divider"></li>
        </ul>
    </li>

    <li class="${controllerName == 'scheduled' || controllerName == 'budget' || controllerName == 'wish' || controllerName == 'loan' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'coins.png')}"/> <g:message code="menu.money"/> <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li class="dropdown-header"><g:message code="scheduleds"/></li>
            <li>
                <g:link controller="scheduled" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> <g:message
                        code="scheduled.list"/></g:link>
            </li>
            <li>
                <g:link controller="scheduled" class="create" action="create"><img
                        src="${resource(dir: 'img', file: 'echeancy.png')}"/>
                    <g:message code="scheduled.create"/>
                </g:link>
            </li>

            <li class="divider"></li>
            <li class="dropdown-header"><g:message code="budgets"/></li>
            <li>
                <g:link controller="budget" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/>
                    <g:message code="budget.list"/>
                </g:link>
            </li>
            <li>
                <g:link controller="budget" class="create" action="create"><img
                        src="${resource(dir: 'img', file: 'coins.png')}"/>
                    <g:message code="budget.create"/>
                </g:link>
            </li>
            <li class="divider"></li>

            <li class="dropdown-header"><g:message code="loans"/></li>
            <li>
                <g:link controller="loan" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/>
                    <g:message code="loan.list"/>
                </g:link>
            </li>
            <li>
                <g:link controller="loan" class="create" action="create"><img
                        src="${resource(dir: 'img', file: 'loan.png')}"/>
                    <g:message code="loan.create"/>
                </g:link>
            </li>
            <li class="divider"></li>

            <li class="dropdown-header"><g:message code="wishes"/></li>
            <li>
                <g:link controller="wish" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/>
                    <g:message code="wish.list"/>
                </g:link>
            </li>
            <li>
                <g:link controller="wish" class="create" action="create"><img
                        src="${resource(dir: 'img', file: 'gift.png')}"/>
                    <g:message code="wish.create"/>
                </g:link>
            </li>
            <li class="divider"></li>

        </ul>
    </li>

    <li class="${controllerName == 'category' || controllerName == 'tiers' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> <g:message code="menu.data"/> <b
                class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link controller="category" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> <g:message
                        code="category.list"/></g:link>
            </li>
            <li>
                <g:link controller="tiers" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> <g:message
                        code="tiers.list"/></g:link>
            </li>
            <li class="divider"></li>
        </ul>
    </li>

    <g:set var="accounts" value="${Account.findAll { owner.id == sec.loggedInUserInfo([field: 'id']) }}"/>
    <g:if test="${accounts}">
        <li class="${controllerName == 'operation' ? "active" : ""} dropdown">
            <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
                <img src="${resource(dir: 'img', file: 'operation.png')}"/> <g:message code="menu.registers"/> <b
                    class="caret"></b>
            </g:link>


            <ul class="dropdown-menu">
                <g:each in="${accounts}" var="account">
                    <li>
                        <g:link controller="operation" params="[account: account.id]" action="list"><img
                                src="${resource(dir: 'img', file: 'operation.png')}"/> ${account.nameAndSold}</g:link>
                    </li>
                </g:each>
                <li class="divider"></li>
            </ul>
        </li>
    </g:if>

</ul>

<ul class="nav navbar-nav navbar-right">
    <sec:ifAllGranted roles="ROLE_ADMIN">
        <li class="${controllerName == 'admin' ? "active" : ""} dropdown">
            <g:link controller="admin" class="dropdown-toggle" data-toggle="dropdown">
                <g:message code="menu.administration"/> <b
                    class="caret"></b>
            </g:link>
            <ul class="dropdown-menu">
                <li>
                    <g:link controller="admin" action="users"><img
                            src="${resource(dir: 'images/skin', file: 'exclamation.png')}"/> <g:message
                            code="admin.list.user"/></g:link>
                </li>
                <li>
                    <g:link controller="admin" action="crons"><img
                            src="${resource(dir: 'images/skin', file: 'exclamation.png')}"/> <g:message
                            code="admin.crons.list.title"/></g:link>
                </li>
                <li class="divider"></li>
            </ul>
        </li>
    </sec:ifAllGranted>

    <li class="${controllerName == 'person' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'personal-information.png')}"/>
            <g:message code="menu.profil" args="${sec.username()}"/> <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link class="personal"
                        controller="person"
                        action="infos"><img
                        src="${resource(dir: 'img', file: 'details.png')}"/> <g:message code="person.informations"/> </g:link>
            </li>
            <li class="divider"></li>
            <li>
                <g:link controller="logout" class="logout">
                    <img src="${resource(dir: 'img', file: 'logout.png')}"/>
                    <g:message code="logout"/>
                </g:link>
            </li>
            <li class="divider"></li>
        </ul>
    </li>
</ul>