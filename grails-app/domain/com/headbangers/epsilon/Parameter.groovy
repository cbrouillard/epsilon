package com.headbangers.epsilon

class Parameter {

    String id

    static belongsTo = Person

    String name
    String value

    Person owner

    static constraints = {
        name nullable:false, blank:false
        value nullable:true, blank:false
        lastUpdated nullable:true
    }

    static mapping = {
        id generator:'uuid'
    }

    Date dateCreated
    Date lastUpdated

    public boolean equals (Parameter obj){
        return this.name.equalsIgnoreCase (obj.name)
    }

    // Paramètres
    // Rapport quotidien : Oui/Non (envoi le montant des comptes par mail le matin)
    // Seuil d'alerte sur un compte : montant (si un des comptes tombent en dessous du seuil , un mail est envoyé)
    // Rapport d'échéances : Oui/Non (envoi le rapport résumant les échéances) 
}
