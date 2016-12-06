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
<html>
<head>
    <title><g:layoutTitle default="Grails"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'epsilon.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datePicker.css')}"/>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    <style>
    #container {
        padding-top: 60px;
        padding-bottom: 40px;
    }
    </style>

    <r:require module="jquery"/>
    <r:require module="bootstrap"/>
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body class="pig">

<nav class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container-fluid">
        <div class="container-fluid">
            <a class="navbar-brand" href="${createLink(uri: '/')}"><img
                    src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Epsilon" border="0"
                    style="height: 20px;"/></a>
        </div>
    </div>
</nav>

<div id="container-fluid">
    <g:layoutBody/>
</div>

<footer>
    <nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
        <div class="navbar-inner">
            <div class="container-fluid">

                <p class="navbar-text pull-left"><span style="-webkit-transform: rotate(180deg); -moz-transform: rotate(180deg); -o-transform: rotate(180deg); -khtml-transform: rotate(180deg); -ms-transform: rotate(180deg); transform: rotate(180deg); display: inline-block;" class="grand">&copy;</span> BROUILLARD Cyril - [2009-2017] - <g:message
                        code="app.name"/> - <g:message code="app.purpose"/> </p>

                <div class="navbar-text pull-right">
                    <a class="label label-danger" href="https://github.com/cbrouillard/epsilon">Fork me on Github !</a>
                </div>

            </div>
        </div>
    </nav>
</footer>

<r:layoutResources/>
</body>

<script>
    jQuery.noConflict();
</script>

</html>