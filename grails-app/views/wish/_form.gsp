<%@ page import="com.headbangers.epsilon.Wish" %>

<div class="control-group">
    <label for="name" class="control-label mandatory"><g:message code="wish.name.label" default="Name"/></label>

    <div class="controls ${hasErrors(bean: wishInstance, field: 'name', 'errors')}">
        <g:textField name="name" value="${wishInstance?.name}" class="input-block-level" required="true"/>
    </div>
</div>

<div class="control-group">
    <label for="webShopUrl" class="control-label mandatory"><g:message code="wish.webShopUrl.label" default="Web Shop Url"/></label>

    <div class="controls ${hasErrors(bean: wishInstance, field: 'webShopUrl', 'errors')}">
        <g:textField name="webShopUrl" value="${wishInstance?.webShopUrl}" class="input-block-level"/>
    </div>
</div>

<div class="control-group">
    <label for="account" class="control-label mandatory"><g:message code="wish.account.label" default="Account"/></label>

    <div class="controls ${hasErrors(bean: wishInstance, field: 'account', 'errors')}">
        <g:select id="account" name="account.id" from="${accounts}" optionKey="id" value="${wishInstance?.account?.id}" class="many-to-one" required="true"/>
    </div>
</div>

<div class="control-group">
    <label for="price" class="control-label mandatory"><g:message code="wish.price.label" default="Price"/></label>

    <div class="controls ${hasErrors(bean: wishInstance, field: 'price', 'errors')}">
        <g:textField name="price" value="${fieldValue(bean: wishInstance, field: 'price')}" required="true"/>
    </div>
</div>

<div class="control-group">
    <label for="previsionBuyDate" class="control-label"><g:message code="wish.previsionBuy.label" default="Prevision Buy"/></label>

    <div class="controls ${hasErrors(bean: wishInstance, field: 'previsionBuy', 'errors')}">
        <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: wishInstance?.previsionBuy)}" name="previsionBuy" id="previsionBuyDate"/>
    </div>
</div>

<div class="control-group">
    <label for="description" class="control-label"><g:message code="wish.description.label" default="Description"/></label>

    <div class="controls ${hasErrors(bean: wishInstance, field: 'description', 'errors')}">
        <g:textArea name="description" cols="40" rows="5" value="${wishInstance?.description}" class="input-block-level"/>
    </div>
</div>
