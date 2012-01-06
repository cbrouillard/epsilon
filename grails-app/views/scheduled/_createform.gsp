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
<g:form method="post" action="save${type}">
  <div class="dialog">

    <table>
      <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="name"><g:message code="scheduled.name.label" default="Name" />:</label>
          </td>
          <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'name', 'errors')}">
      <g:textField name="name" value="${fieldValue(bean: scheduledInstance, field: 'name')}" />
      </td>
      <td valign="top" class="name">
        <label for="dateApplication"><g:message code="scheduled.dateApplication.label" default="Date Application" /></label>
      </td>
      <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'dateApplication', 'errors')}">
        <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:scheduledInstance?.dateApplication)}" name="dateApplication" id="dateApplication${type}"/>
      </td>
      </tr>

      <tr class="prop">
      <td valign="top" class="name">
        <label for="tiers"><g:message code="scheduled.tiers.label" default="Tiers" /></label>
      </td>
      <td valign="top" class="mandatory  value ${hasErrors(bean: scheduledInstance, field: 'tiers', 'errors')}">
      <richui:autoComplete id="tiers${type}" name="tiers.name" action="${createLinkTo('dir': 'tiers/autocomplete')}" value="${scheduledInstance?.tiers?.name}"/>
      </td>
      <td valign="top" class="name">
        <label for="dateLastApplication"><g:message code="scheduled.dateLastApplication.label" default="Date Last Application" /></label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'dateLastApplication', 'errors')}">
        <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:scheduledInstance?.dateLastApplication)}" name="dateLastApplication" id="dateLastApplication${type}"/>
      </td>
      </tr>

      <tr class="prop">

      <td valign="top" class="name">
        <label for="category"><g:message code="scheduled.category.label" default="Category" /></label>
      </td>
      <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'category', 'errors')}">
      <richui:autoComplete id="category${type}" name="category.name" action="${createLinkTo('dir': 'category/autocomplete/'+type)}"  value="${scheduledInstance?.category?.name}"/>
      </td>
      <td valign="top" class="name">
          <label for="amount"><g:message code="scheduled.amount.label" default="Amount" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'amount', 'errors')}">
      <g:textField name="amount" value="${fieldValue(bean: scheduledInstance, field: 'amount')}" />
      </td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="note"><g:message code="scheduled.note.label" default="Note" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'note', 'errors')}">
      <g:textArea name="note" cols="40" rows="5" value="${scheduledInstance?.note}" />
      </td>

        <td valign="top" class="name">
          <label for="accountFrom"><g:message code="scheduled.account.label" default="Account" />:</label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'accountFrom', 'errors')}">
      <g:select optionValue="name" name="accountFrom.id" from="${accounts}" optionKey="id" value="${scheduledInstance?.accountFrom?.id}"  />
      </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="automatic"><g:message code="scheduled.automatic.label" default="Automatic" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'automatic', 'errors')}">
      <g:checkBox name="automatic" value="${scheduledInstance?.automatic}" />
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      </tr>

      </tbody>
    </table>

    <jq:jquery>
      jQuery("#dateApplication${type}").datePicker({clickInput:true, startDate:'01/01/1996'});
      jQuery("#dateLastApplication${type}").datePicker({clickInput:true, startDate:'01/01/1996'});
    </jq:jquery>
  </div>
  <div class="buttons">
    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
  </div>



</g:form>
