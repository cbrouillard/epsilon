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
<g:hasErrors bean="${operationInstance}">
  <div class="errors">
    <g:renderErrors bean="${operationInstance}" as="list" />
  </div>
</g:hasErrors>
<g:form action="save${type}" method="post" >
  <div class="dialog">
    <table>
      <tbody>

      <input name="account.id" type="hidden" value="${selected?.id}"/>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="tiers"><g:message code="operation.tiers.label" default="Tiers" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'tiers', 'errors')}">

      <richui:autoComplete id="tiers${type}" name="tiers.name" action="${createLinkTo('dir': 'tiers/autocomplete')}" value="${operationInstance?.tiers?.name}" 
                           onItemSelect="tryToGuessCategoryWithTiersId(id, 'category${type}');" />
      </td>

      <td valign="top" class="name">
        <label for="dateApplication"><g:message code="operation.dateApplication.label" default="Date Application" /></label>
      </td>
      <td valign="top" class="mandatory  value ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">
        <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:operationInstance?.dateApplication)}" name="dateApplication" id="dateApplication${type}"/>
      </td>

      <jq:jquery>
        jQuery("#dateApplication${type}").datePicker({clickInput:true, startDate:'01/01/1996'})
        .val(new Date().asString()).trigger('change');
      </jq:jquery>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="category"><g:message code="operation.category.label" default="Category" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">
      <richui:autoComplete id="category${type}" name="category.name" action="${createLinkTo('dir': 'category/autocomplete/'+type)}"  value="${operationInstance?.category?.name}"/>
      </td>

      <td valign="top" class="name">
        <label for="amount"><g:message code="operation.amount.label" default="Amount" /></label>
      </td>
      <td valign="top" class="mandatory  value ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">
      <g:textField name="amount" value="${fieldValue(bean: operationInstance, field: 'amount')}" />
      </td>
      </tr>


      <tr class="prop">
        <td valign="top" class="name">
          <label for="note"><g:message code="operation.note.label" default="Note" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">
      <g:textArea name="note" cols="40" rows="50" value="${operationInstance?.note}"/>
      </td>

      <td valign="top" class="name">
        <label for="pointed"><g:message code="operation.pointed.label" default="Pointed" /></label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: operationInstance, field: 'pointed', 'errors')}">
      <g:checkBox name="pointed" value="${operationInstance?.pointed}" />
      </td>
      </tr>

      </tbody>
    </table>
  </div>
  <div class="buttons">
    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
  </div>
</g:form>
