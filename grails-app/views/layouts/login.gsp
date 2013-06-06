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

    <script>
        jQuery.noConflict();
    </script>

    <r:require module="bootstrap"/>
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body class="pig">

<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="brand" href="${createLink(uri: '/')}"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Epsilon" border="0"
                                                                 style="height: 20px;"/></a>
        </div>
    </div>
</div>

<div id="container">
    <g:layoutBody/>
</div>

<footer>
    <div class="navbar navbar-fixed-bottom">
        <div class="navbar-inner">
            <div class="container-fluid">

                <p class="navbar-text pull-left">© BROUILLARD Cyril - 2013 - <g:message
                        code="app.name"/> - Gestion simplifiée de compte bancaires</p>

            </div>
        </div>
    </div>
</footer>

<r:layoutResources/>
</body>

</html>