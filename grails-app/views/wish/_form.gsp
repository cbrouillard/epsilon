<%@ page import="com.headbangers.epsilon.Wish" %>

<table>
  <tbody>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="account">
          <g:message code="wish.account.label" default="Account" />
        </label>
      </td>
      <td valign="top" class="mandatory value ${hasErrors(bean: wishInstance, field: 'account', 'errors')}">
  <g:select id="account" name="account.id" from="${accounts}" optionKey="id" value="${wishInstance?.account?.id}" class="many-to-one"/>
</td>
</tr>

<tr class="prop">
  <td valign="top" class="name">
    <label for="name">
      <g:message code="wish.name.label" default="Name" />
    </label>
  </td>
  <td valign="top" class="mandatory value ${hasErrors(bean: wishInstance, field: 'name', 'errors')}">
<g:textField name="name" value="${wishInstance?.name}"/>
</td>
</tr>

<tr class="prop">
  <td valign="top" class="name">
    <label for="price">
      <g:message code="wish.price.label" default="Price" />
    </label>
  </td>
  <td valign="top" class="mandatory value ${hasErrors(bean: wishInstance, field: 'price', 'errors')}">
<g:field type="number" name="price" value="${fieldValue(bean: wishInstance, field: 'price')}"/>
</td>
</tr>

<tr class="prop">
  <td valign="top" class="name">
    <label for="webShopUrl">
      <g:message code="wish.webShopUrl.label" default="Web Shop Url" />

    </label>
  </td>
  <td valign="top" class="value ${hasErrors(bean: wishInstance, field: 'webShopUrl', 'errors')}">
<g:textField name="webShopUrl" value="${wishInstance?.webShopUrl}"/>
</td>
</tr>

<tr class="prop">
  <td valign="top" class="name">
    <label for="previsionBuy">
      <g:message code="wish.previsionBuy.label" default="Prevision Buy" />

    </label>
  </td>
  <td valign="top" class="value ${hasErrors(bean: wishInstance, field: 'previsionBuy', 'errors')}">
    <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:wishInstance?.previsionBuy)}" name="previsionBuy" id="previsionBuyDate"/>

<jq:jquery>
  jQuery("#previsionBuyDate").datePicker({clickInput:true, startDate:'01/01/1996'})
  .val(new Date().asString()).trigger('change');
</jq:jquery>
</td>
</tr>

<tr class="prop">
  <td valign="top" class="name">
    <label for="description">
      <g:message code="wish.description.label" default="Description" />

    </label>
  </td>
  <td valign="top" class="value ${hasErrors(bean: wishInstance, field: 'description', 'errors')}">
<g:textArea name="description" cols="40" rows="5" value="${wishInstance?.description}" />
</td>
</tr>

</tbody>
</table>
