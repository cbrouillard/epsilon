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
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'epsilon.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datePicker.css')}"/>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    %{--<script src="${resource(dir:'/js/jquery',file:'jquery-1.4.2-min.js')}" type="text/javascript" library="jquery"></script>--}%

    <script src="${resource(dir: '/js', file: 'date.js')}"></script>
    <script src="${resource(dir: '/js', file: 'jquery.datePicker.js')}"></script>
    <script src="${resource(dir: '/js/calculator', file: 'jquery.calculator.js')}"></script>

    <script src="${resource(dir: '/js/fancybox', file: 'jquery.fancybox-1.3.1.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: '/js/fancybox', file: 'jquery.fancybox-1.3.1.css')}"/>

    <export:resource/>

    <style>
    #container {
        padding-top: 60px;
        padding-bottom: 40px;
    }
    </style>

    <script>
        jQuery.noConflict();
    </script>
    <script src="${resource(dir: '/js', file: 'password.js')}"></script>

    <script src="${resource(dir: '/js/prototype', file: 'prototype.js')}"></script>
    <script src="${resource(dir: '/js', file: 'application.js')}"></script>

    <ofchart:resources/>

    <r:require module="bootstrap"/>
    <g:layoutHead/>
    <r:layoutResources/>

</head>

<body class="pig">

<jq:jquery>
    jQuery("a.popup").fancybox(
    {showNavArrows:false, 'zoomSpeedIn' : 300,
    'zoomSpeedOut': 300,
    'overlayShow': true,
    'hideOnContentClick': false,
    'callbackOnShow': function() {
    jQuery("#fancy_right").hide();
    jQuery("#fancy_left").hide();
    }
    }
    );
    //jQuery("a[title]").qtip({ style: { name: 'dark', tip: true }, position : {corner:{target:'topRight', tooltip:'bottomLeft'}} });
</jq:jquery>



<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="brand" href="${createLink(uri: '/')}"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Epsilon" border="0"
                                                                 style="height: 20px;"/></a>

            <g:render template="/generic/menu"/>
        </div>
    </div>
</div>

<div id="container">
    <g:layoutBody/>
</div>

<div class="clean"></div>

<footer>
    <div class="navbar navbar-fixed-bottom">
        <div class="navbar-inner">
            <div class="container-fluid">

                <p class="navbar-text pull-left">
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <g:link controller="admin" class="yellow">Administration</g:link> -
                    </sec:ifAllGranted>
                    © BROUILLARD Cyril - 2013 - <g:message
                            code="app.name"/> - Gestion simplifiée de compte bancaires</p>

            </div>
        </div>
    </div>
</footer>

<r:layoutResources/>
</body>

</html>