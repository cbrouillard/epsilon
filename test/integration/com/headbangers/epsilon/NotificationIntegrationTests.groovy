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

import grails.test.*

class NotificationIntegrationTests extends GrailsUnitTestCase {

    protected List<Scheduled> scheduledList = new ArrayList<Scheduled>()
    def user_admin

    def notificationService

    protected void setUp() {
        super.setUp()

        //notificationService = new NotificationService()

        user_admin = new Person(username: "admin",
                userRealName: "Administrateur Epsilon",
                passwd: 'md5pass',
                enabled: true,
                email: "cyril.brouillard@gmail.com",
                emailShow: false,
                description: "Administrateur Epsilon")
        def user_admin2 = new Person(username: "joined",
                userRealName: "Administrateur Epsilon",
                passwd: 'md5pass',
                enabled: true,
                email: "cyril.brouillard@gmail.com",
                emailShow: false,
                description: "Administrateur Epsilon")

        def bank = new Bank(name: "CA",
                description: "Crédit Agricole",
                owner: user_admin)
        def tiers = new Tiers(
                name: "Epsilon Enterprise",
                description: "Ma société",
                owner: user_admin)
        def category = new Category(
                name: "Loisir",
                type: CategoryType.DEPENSE,
                description: "Dépense pour loisir.",
                owner: user_admin)
        def account = new Account(name: "Compte commun",
                bank: bank,
                type: AccountType.CHEQUES,
                dateOpened: new Date(),
                amount: 1000.8784D,
                description: "Un compte de test",
                owner: user_admin, joinOwner: user_admin2)
        def account2 = new Account(name: "Compte perso",
                bank: bank,
                type: AccountType.CHEQUES,
                dateOpened: new Date(),
                amount: 1000.8784D,
                description: "Un compte de test",
                owner: user_admin)


        def scheduled = new Scheduled(
                type: OperationType.FACTURE,
                tiers: tiers,
                category: category,
                accountFrom: account,
                name: "Echeance test",
                dateApplication: new Date(),
                amount: 45D,
                automatic: true, owner: user_admin)

        def scheduled2 = new Scheduled(
                type: OperationType.FACTURE,
                tiers: tiers,
                category: category,
                accountFrom: account2,
                name: "Echeance test perso",
                dateApplication: new Date(),
                amount: 105D,
                automatic: true, owner: user_admin)

        scheduledList.add(scheduled)
        scheduledList.add(scheduled2)

    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSendScheduledMail() {
        log.info "Lancement du test"
        notificationService.sendScheduledDoneMail(user_admin, scheduledList)

    }
}
