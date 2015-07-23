<g:form class="form-inline pull-right"  action="${action}" controller="${controller}" method="get" style="${css}">
    <g:hiddenField name="id" value="${id}" />
    Entre <g:select name="fromYear" from="${yearRange}" value="${fromYear}" class="form-control"/>
    et <g:select name="toYear" from="${yearRange}" value="${toYear}" class="form-control"/>
    <input type="submit" value="Ok" class="btn btn-default"/>
</g:form>