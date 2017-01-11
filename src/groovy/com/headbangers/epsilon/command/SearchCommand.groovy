package com.headbangers.epsilon.command

import grails.validation.Validateable

@Validateable (nullable = true)
class SearchCommand {

    String id
    String tiers
    String category
    Date beforeDate
    Date afterDate

    boolean couldApply (){
        return tiers || category || beforeDate || afterDate
    }
}