<%@ page import="com.headbangers.epsilon.Account" %>
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
<ul class="nav navbar-nav">
    <li class="${controllerName == 'bank' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'bank.png')}"/> Etablissements <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link controller="bank" class="list" action="list"><img src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Liste des
                 établissements</g:link>
            </li>
            <li>
                <g:link controller="bank" class="create" action="create"><img
                        src="${resource(dir: 'images/skin', file: 'database_add.png')}"/> Nouvel établissement</g:link>
            </li>
        </ul>
    </li>

    <li class="${controllerName == 'account' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'account.png')}"/> Comptes <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link controller="account" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Liste des comptes</g:link>
            </li>
            <li>
                <g:link controller="account" class="create" action="create"><img
                        src="${resource(dir: 'images/skin', file: 'database_add.png')}"/> Nouveau compte</g:link>
            </li>
        </ul>
    </li>

    <li class="${controllerName == 'scheduled' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'echeancy.png')}"/> Echéances <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link controller="scheduled" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Liste des échéances</g:link>
            </li>
            <li>
                <g:link controller="scheduled" class="create" action="create"><img
                        src="${resource(dir: 'images/skin', file: 'database_add.png')}"/> Nouvelle échéance</g:link>
            </li>
        </ul>
    </li>

    <li class="${controllerName == 'budget' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'coins.png')}"/> Budgets <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link controller="budget" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Liste des budgets</g:link>
            </li>
            <li>
                <g:link controller="budget" class="create" action="create"><img
                        src="${resource(dir: 'images/skin', file: 'database_add.png')}"/> Nouveau budget</g:link>
            </li>
        </ul>
    </li>

    <li class="${controllerName == 'wish' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'gift.png')}"/> Futurs achats <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link controller="wish" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Liste des futurs achats</g:link>
            </li>
            <li>
                <g:link controller="wish" class="create" action="create"><img
                        src="${resource(dir: 'images/skin', file: 'database_add.png')}"/> Nouveau souhait d'achat</g:link>
            </li>
        </ul>
    </li>

    <li class="${controllerName == 'loan' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'loan.png')}"/> Prêts <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link controller="loan" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Liste des prêts</g:link>
            </li>
            <li>
                <g:link controller="loan" class="create" action="create"><img
                        src="${resource(dir: 'images/skin', file: 'database_add.png')}"/> Nouveau prêt</g:link>
            </li>
        </ul>
    </li>

    <li class="${controllerName == 'category' || controllerName == 'tiers' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Données <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link controller="category" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Liste des catégories</g:link>
            </li>
            <li>
                <g:link controller="tiers" class="list" action="list"><img
                        src="${resource(dir: 'images/skin', file: 'database_table.png')}"/> Liste des tiers</g:link>
            </li>
        </ul>
    </li>

    <li class="${controllerName == 'operation' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'operation.png')}"/> Registres <b class="caret"></b>
        </g:link>
        <g:set var="accounts" value="${Account.findAll{ owner.id == sec.loggedInUserInfo([field: 'id']) }}"/>

        <ul class="dropdown-menu">
            <g:each in="${accounts}" var="account">
                <li>
                    <g:link controller="operation" params="[account: account.id]" action="list"><img src="${resource(dir: 'img', file: 'operation.png')}"/> ${account.nameAndSold}</g:link>
                </li>
            </g:each>
        </ul>
    </li>

</ul>

<ul class="nav navbar-nav navbar-right">
    <li class="${controllerName == 'person' ? "active" : ""} dropdown">
        <g:link controller="bank" class="dropdown-toggle" data-toggle="dropdown">
            <img src="${resource(dir: 'img', file: 'personal-information.png')}"/> Profil [<b><sec:username/></b>] <b class="caret"></b>
        </g:link>
        <ul class="dropdown-menu">
            <li>
                <g:link class="stats"
                        controller="stats"><img src="${resource(dir: 'img', file: 'stats.png')}"/> Statistiques</g:link>
            </li>
            <li>
                <g:link class="personal"
                        controller="person"
                        action="infos"><img src="${resource(dir: 'img', file: 'details.png')}"/> Vos informations</g:link>
            </li>
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <li>

                    <g:link controller="admin"><img src="${resource(dir: 'images/skin', file: 'exclamation.png')}"/> Administration</g:link>
                </li>
            </sec:ifAllGranted>
            <li class="divider"></li>
            <li>
                <g:link controller="logout" class="logout">
                    <img src="${resource(dir: 'img', file: 'logout.png')}"/>
                    Se déconnecter
                </g:link>
            </li>
        </ul>
    </li>
</ul>