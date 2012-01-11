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

package com.headbangers.epsilon

class Parameter {

    String id

    static belongsTo = Person

    String name
    String value
    String type

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
