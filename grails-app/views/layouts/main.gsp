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
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    <r:require module="jquery"/>

    <style>
    #container {
        padding-top: 60px;
        padding-bottom: 60px;
    }
    </style>

    <script src="${resource(dir: '/js', file: 'password.js')}"></script>
    %{--<script src="${resource(dir: '/js', file: 'application.js')}"></script>--}%

    %{--<ofchart:resources/>--}%

    <ofchart:resources/>
    <r:require module="bootstrap"/>
    <r:require module="jquery-ui"/>
    <g:layoutHead/>
    <r:layoutResources/>

</head>

<body class="pig">

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

<footer>
    <div class="navbar navbar-fixed-bottom">
        <div class="navbar-inner">
            <div class="container-fluid">

                <p class="navbar-text pull-left">
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <g:link controller="admin">Administration</g:link> -
                    </sec:ifAllGranted>
                    © BROUILLARD Cyril - 2013 - <g:message
                            code="app.name"/> - Gestion simplifiée de compte bancaires</p>

            </div>
        </div>
    </div>
</footer><a name="bottom"></a>

<r:layoutResources/>
</body>

<script type="text/javascript">
    jQuery(function () {
//        , showOn: 'both', buttonText: '<i class="icon-calendar"></i>'
        $(".datepicker, .datepicker-inner").datepicker({'dateFormat': 'dd/mm/yy'});

        $(".datepicker, .datepicker-inner").attr("autocomplete", "off");

        $('.typeahead-tiers').typeahead({
            source: function (query, process) {
                return $.get('${createLink(controller: 'tiers', action:'simpleautocomplete')}', { query: query },
                        function
                                (data) {
                            return process(data);
                        });
            }
        });

        $('.typeahead-categories-facture, .typeahead-categories-retrait').typeahead({
            source: function (query, process) {
                return $.get('${createLink(controller: 'category', action:'simpleautocomplete')}', { query: query },
                        function
                                (data) {
                            return process(data);
                        });
            }
        });

        $('.typeahead-categories-depot').typeahead({
            source: function (query, process) {
                return $.get('${createLink(controller: 'category', action:'simpleautocomplete')}', { query: query, type: 'depot' },
                        function
                                (data) {
                            return process(data);
                        });
            }
        });

        $('.typeahead-categories-virement').typeahead({
            source: function (query, process) {
                return $.get('${createLink(controller: 'category', action:'simpleautocomplete')}', { query: query, type: 'virement' },
                        function
                                (data) {
                            return process(data);
                        });
            }
        });

    });
</script>
</html>