<%@ page import="com.headbangers.epsilon.Wish" %>

<div class="form-group ${hasErrors(bean: wishInstance, field: 'name', 'has-error')}">

    <label for="name" class="col-sm-2 control-label mandatory"><g:message
            code="wish.name.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-font"></span></span>
            <g:textField name="name" required="true" value="${wishInstance?.name}"
                         class="form-control" autofocus=""/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: wishInstance, field: 'price', 'has-error')}">

    <label for="price" class="col-sm-2 control-label mandatory"><g:message
            code="wish.price.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-euro"></span></span>
            <g:textField pattern="^([0-9.,])*" name="price" value="${formatNumber(number:wishInstance?.price, format:'0.##')}" required="true" class="form-control"/>
        </div>

        <g:if test="${wishInstance?.priceFromWebsite}">
            <div class="help-block">
                Prix affiché sur le site web : <span class="label label-default">${wishInstance?.priceFromWebsite}</span></div>
        </g:if>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: wishInstance, field: 'webShopUrl', 'has-error')}">

    <label for="webShopUrl" class="col-sm-2 control-label"><g:message
            code="wish.webShopUrl.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-link"></span></span>
            <g:textField name="webShopUrl"  value="${wishInstance?.webShopUrl}"
                         class="form-control"/>
        </div>

        <g:if test="${wishInstance?.webShopUrl}">
            <div class="help-block">
                <a href="${wishInstance?.webShopUrl}" class="btn btn-default" target="_blank">Ouvrir la page boutique</a></div>
        </g:if>
        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: wishInstance, field: 'thumbnailUrl', 'has-error')}">

    <label for="thumbnailUrl" class="col-sm-2 control-label"><g:message
            code="wish.thumbnailUrl.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-link"></span></span>
            <g:textField name="thumbnailUrl"  value="${wishInstance?.thumbnailUrl}"
                         class="form-control"/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: wishInstance, field: 'account', 'errors')}">

    <label for="account" class="col-sm-2 control-label mandatory"><g:message
            code="wish.account.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-piggy-bank"></span></span>
            <g:select id="account" name="account.id" from="${accounts}" optionKey="id" value="${wishInstance?.account?.id}" class="many-to-one form-control"
                      required="required"/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: wishInstance, field: 'category', 'errors')}">

    <label for="category" class="col-sm-2 control-label"><g:message
            code="operation.category.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-tag"></span></span>

            <g:textField id="category" name="category.name"
                         value="${wishInstance?.category?.name}"
                         class="form-control typeahead-categories-facture"
                         autocomplete="off"/>

        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>


<div class="form-group ${hasErrors(bean: wishInstance, field: 'previsionBuy', 'has-error')}">

    <label for="previsionBuyDate" class="col-sm-2 control-label"><g:message
            code="wish.previsionBuy.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-calendar"></span></span>
            <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: wishInstance?.previsionBuy)}" name="previsionBuy" id="previsionBuyDate"
                   class="datePicker form-control"/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: wishInstance, field: 'description', 'has-error')}">

    <label for="description" class="col-sm-2 control-label"><g:message
            code="wish.description.label"/></label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-star"></span></span>
            <g:textArea name="description" cols="40" rows="5" value="${wishInstance?.description}"
                        class="form-control editor"/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>
