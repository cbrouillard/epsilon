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

<%@ page contentType="text/html;charset=UTF-8" %>
<g:form action="save" >
  <div class="dialog">
    <g:hiddenField name="type" value="${type}" />
    <table>
      <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="name"><g:message code="loan.name.label" default="Name" /></label>
          </td>
          <td valign="top" class="mandatory value ${hasErrors(bean: loanInstance, field: 'name', 'errors')}">
      <g:textField name="name" value="${fieldValue(bean: loanInstance, field: 'name')}" />
      </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="tiers"><g:message code="loan.tiers.label" default="Tiers" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: loanInstance, field: 'tiers', 'errors')}">
      <richui:autoComplete id="tiers${type}" name="tiers.name" action="${createLinkTo('dir': 'tiers/autocomplete')}" value="${loanInstance?.tiers?.name}"/>
      </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="accountFrom"><g:message code="scheduled.account.label" default="Account" />:</label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: scheduled, field: 'accountFrom', 'errors')}">
      <g:select optionValue="name" name="accountFrom.id" from="${accounts}" optionKey="id" value="${scheduled?.accountFrom?.id}"  />
      </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="amount"><g:message code="loan.amount.label" default="Amount" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: loanInstance, field: 'amount', 'errors')}">
      <g:textField name="amount" value="${fieldValue(bean: loanInstance, field: 'amount')}" />
      </td>
      </tr>
      
      <tr class="prop">
        <td valign="top" class="name">
          <label for="interest"><g:message code="loan.interest.label" default="Interest" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'interest', 'errors')}">
      <g:textField name="interest" value="${fieldValue(bean: loanInstance, field: 'interest')}" />
      </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="refundValue"><g:message code="loan.refundValue.label" default="Refund" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: loanInstance, field: 'refundValue', 'errors')}">
      <g:textField name="refundValue" value="${fieldValue(bean: loanInstance, field: 'refundValue')}" />
      </td>
      </tr>


      <tr class="prop">
        <td valign="top" class="name">
          <label for="dateApplication"><g:message code="scheduled.dateApplication.label" default="Date Application" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: scheduled, field: 'dateApplication', 'errors')}">
          <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:scheduled?.dateApplication)}" name="dateApplication" id="dateApplication${type}"/>
        </td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="description"><g:message code="loan.description.label" default="Description" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'description', 'errors')}">
      <g:textArea name="description" cols="40" rows="5" value="${loanInstance?.description}" />
      </td>
      </tr>

      </tbody>
    </table>
  </div>
  <div class="buttons">
    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
  </div>

  <jq:jquery>
    jQuery("#dateApplication${type}").datePicker({clickInput:true, startDate:'01/01/1996'});
    jQuery("#dateLastApplication${type}").datePicker({clickInput:true, startDate:'01/01/1996'});
  </jq:jquery>

</g:form>