<div class="alert alert-info">Filtrage</div>
<g:form class="form-inline text-right" action="${action}" controller="${controller}" method="get">
    <g:hiddenField name="id" value="${id}" />
    Entre <g:select name="fromYear" from="${yearRange}" value="${fromYear}" class="input-small"/>
    et <g:select name="toYear" from="${yearRange}" value="${toYear}" class="input-small"/>
    <input type="submit" value="Ok" class="btn btn-primary"/>
</g:form>