<%@ page import="com.headbangers.epsilon.Account" %>
<div class="form-group ${hasErrors(bean: threshold, field: 'account', 'errors')}">

    <label for="account" class="col-sm-2 control-label mandatory"><g:message
            code="threshold.account.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-piggy-bank"></span></span>
            <g:select id="account" optionValue="name" name="account.id"
                      from="${Account.findAllByOwner(threshold?.owner)}"
                      optionKey="id"
                      value="${threshold?.account?.id}"
                      required="required"
                      class="form-control"/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: threshold, field: 'name', 'has-error')}">

    <label for="name" class="col-sm-2 control-label mandatory"><g:message
            code="threshold.name.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-font"></span></span>
            <g:textField name="name" required="true" value="${threshold?.name}"
                         class="form-control" autofocus=""/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: threshold, field: 'value', 'has-error')}">

    <label for="value" class="col-sm-2 control-label mandatory"><g:message
            code="threshold.value.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-euro"></span></span>
            <g:textField name="value" required="true"
                         value="${formatNumber(number: threshold?.value, format: '0.##')}"
                         class="form-control" pattern="^([-0-9.,])*"/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: threshold, field: 'color', 'has-error')}">

    <label for="color" class="col-sm-2 control-label mandatory"><g:message
            code="threshold.color.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-tint"></span></span>
            <g:textField name="color" required="true" value="${threshold?.color}"
                         class="form-control jscolor {hash:true}"/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group">
    <label for="active" class="col-sm-2 control-label"><g:message
            code="threshold.active.label"/></label>

    <div class="col-sm-10">
        <div class="checkbox">
            <label>
                <g:checkBox id="active" name="active"
                            value="${threshold?.active}" class="checkbox"/>
            </label>
        </div>
    </div>
</div>