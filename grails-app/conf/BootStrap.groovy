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


import com.headbangers.epsilon.*
import java.text.SimpleDateFormat
class BootStrap {

    def springSecurityService
    def accountService
    
    def init = { servletContext ->

        //        def md5pass = springSecurityService.passwordEncoder("admin")
        //        def testpass = springSecurityService.passwordEncoder("test")
        //
        //        def user_admin = new Person(username:"admin",
        //            userRealName:"Administrateur Epsilon",
        //            passwd: md5pass,
        //            enabled:true,
        //            email:"cyril.brouillard@gmail.com",
        //            emailShow:false,
        //            description:"Administrateur Epsilon").save(flush:true)
        //
        //        def user_test = new Person(username:"test",
        //            userRealName:"User Test",
        //            passwd: testpass,
        //            enabled:true,
        //            email:"test@epsilon.com",
        //            emailShow:false,
        //            description:"Le test Epsilon").save(flush:true)
        //
        //        def role_admin = new Role(description:"Administrateur",
        //            authority:"ROLE_ADMIN")
        //        def role_user = new Role(description:"Utilisateur",
        //            authority:"ROLE_USER")
        //        role_admin.addToPeople(user_admin)
        //        role_admin.save(flush:true)
        //        role_user.addToPeople(user_test)
        //        role_user.save(flush:true)
        //
        //        def bank = new Bank (name:"CA",
        //            description:"Crédit Agricole",
        //            owner:user_admin).save(flush:true)
        //
        //        def account = new Account (name:"Compte courant",
        //            bank:bank,
        //            type: AccountType.CHEQUES,
        //            dateOpened:new Date(),
        //            amount: 1000.8784D,
        //            description:"Un compte de test",
        //            owner:user_admin).save(flush:true)
        //        def snapshot1 = new Snapshot (account:account, amount:account.amount).save(flush:true)
        //        def account2 = new Account (name:"Compte épargne",
        //            bank:bank,
        //            type: AccountType.EPARGNE,
        //            dateOpened:new Date(),
        //            amount: 500D,
        //            description:"Un compte de test",
        //            owner:user_admin).save(flush:true)
        //        def snapshot2 = new Snapshot (account:account2, amount:account2.amount).save(flush:true)
        //
        //        def category = new Category (
        //            name:"Salaire",
        //            type:CategoryType.REVENU,
        //            description:"Salaire boulot ...",
        //            owner:user_admin).save(flush:true)
        //        def category2 = new Category (
        //            name:"Loisir",
        //            type:CategoryType.DEPENSE,
        //            description:"Dépense pour loisir.",
        //            owner:user_admin).save(flush:true)
        //
        //        def tiers = new Tiers (
        //            name:"Epsilon Enterprise",
        //            description:"Ma société",
        //            owner:user_admin).save(flush:true)
        //
        //        def snapshot3 = new Snapshot (account:account, amount:account.amount, previous:snapshot1).save(flush:true)
        //
        //
        //        def operation1 = new Operation (
        //            type:OperationType.RETRAIT,
        //            tiers:tiers,
        //            category:category2,
        //            account:account,
        //            dateApplication:new Date(), amount:100.67812D, owner:user_admin).save(flush:true)
        //        def operation2 = new Operation (
        //            type:OperationType.RETRAIT,
        //            tiers:tiers,
        //            category:category2,
        //            account:account,
        //            dateApplication:new Date(), amount:30.9801D, owner:user_admin).save(flush:true)
        //        def operation3 = new Operation (
        //            type:OperationType.RETRAIT,
        //            tiers:tiers,
        //            category:category2,
        //            account:account,
        //            dateApplication:new Date(), amount:36.657211D, owner:user_admin).save(flush:true)
        //
        //        def scheduled = new Scheduled (
        //            type:OperationType.FACTURE,
        //            tiers:tiers,
        //            category:category2,
        //            accountFrom:account,
        //            name:"Echeance test",
        //            dateApplication:new Date(),
        //            amount:45D,
        //            automatic:true, owner:user_admin).save(flush:true)
        //        def late = new Scheduled (
        //            type:OperationType.FACTURE,
        //            tiers:tiers,
        //            category:category2,
        //            accountFrom:account,
        //            name:"Echeance test en retard",
        //            dateApplication:new SimpleDateFormat("dd/MM/yyyy").parse("10/05/2009"),
        //            amount:100.01D,
        //            automatic:false, owner:user_admin).save(flush:true)
        //        def today = new Scheduled (
        //            type:OperationType.FACTURE,
        //            tiers:tiers,
        //            category:category2,
        //            accountFrom:account,
        //            name:"Echeance test",
        //            dateApplication:new Date(),
        //            amount:50D,
        //            automatic:false, owner:user_admin).save(flush:true)
        //        def future = new Scheduled (
        //            type:OperationType.FACTURE,
        //            tiers:tiers,
        //            category:category2,
        //            accountFrom:account,
        //            name:"Echeance test futur (trés loin)",
        //            dateApplication:new SimpleDateFormat("dd/MM/yyyy").parse("10/06/2015"),
        //            amount:105D,
        //            automatic:false, owner:user_admin).save(flush:true)

        
        //        accountService.rebuildAllSnapshots()
        
//        def persons = Person.list()
//        persons.each { person -> 
//        
//            def parameters = new HashMap<String, String>()
//            person.parameters.each{parameter -> 
//                parameters.put (parameter.name, parameter.value)
//            }
//            
//            if (!parameters.bayesian_filter){
//                Parameter bayesianFilter = new Parameter (name:"bayesian_filter", value:"true", owner:person, type:"boolean")
//                bayesianFilter.save(flush:true)
//            }
//            
//        }
        
        
    }
    def destroy = {
    }
} 