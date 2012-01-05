package com.headbangers.epsilon

class Loan {

    String id
    static belongsTo = [Person]
    
    Double amount
    String description
    
    Date startDate
    Date endDate
    
    Scheduled scheduled
    Person owner
    Tiers tiers
    LoanType type
    
    static constraints = {
        type nullable:false, blank:false
        tiers nullable:false
        owner nullable:false
        amount nullable:false, blank:false
        
        scheduled nullable:true
        startDate nullable:true, blank:false
        endDate nullable:true, blank:false
        description nullable:true, blank:false, widget:'textarea'
    }
    
    static mapping = {
        id generator:'uuid'
        description type:'text'
    }

    Date dateCreated
    Date lastUpdated
}
