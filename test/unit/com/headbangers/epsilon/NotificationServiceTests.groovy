package com.headbangers.epsilon

import grails.test.*

class NotificationServiceTests extends GrailsUnitTestCase {

    protected List<Scheduled> scheduledList = new ArrayList<Scheduled>()
    def user_admin

    def notificationService

    protected void setUp() {
        super.setUp()

        //notificationService = new NotificationService()

        user_admin = new Person(username:"admin",
            userRealName:"Administrateur Epsilon",
            passwd: 'md5pass',
            enabled:true,
            email:"cyril.brouillard@gmail.com",
            emailShow:false,
            description:"Administrateur Epsilon")
        def bank = new Bank (name:"CA",
            description:"Crédit Agricole",
            owner:user_admin)
        def tiers = new Tiers (
            name:"Epsilon Enterprise",
            description:"Ma société",
            owner:user_admin)
        def category = new Category (
            name:"Loisir",
            type:CategoryType.DEPENSE,
            description:"Dépense pour loisir.",
            owner:user_admin)
        def account = new Account (name:"Compte courant",
            bank:bank,
            type: AccountType.CHEQUES,
            dateOpened:new Date(),
            amount: 1000.8784D,
            description:"Un compte de test",
            owner:user_admin)
        
        def scheduled = new Scheduled (
            type:OperationType.FACTURE,
            tiers:tiers,
            category:category,
            accountFrom:account,
            name:"Echeance test",
            dateApplication:new Date(),
            amount:45D,
            automatic:true, owner:user_admin)

    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSendScheduledMail() {

        notificationService.sendScheduledDoneMail (user_admin, scheduledList)

    }
}
