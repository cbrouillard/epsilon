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


class AccountSnapshotJob {
    def timeout = 5000l // execute job once in 5 seconds

    //cron name: 'le1dumoisa1h', cronExpression: "0 0 1 1 * ?"
    //cron name:'dev2mn', cronExpression: "0 0/2 * * * ?"
    static triggers = {
        cron name: 'le1dumoisa0h', cronExpression: "0 0 0 1 * ?"
    }

    def execute() {
        // getting back all account
        def accounts = Account.list()
        accounts.each { account ->
            log.debug ("Treating this account : ${account.name}")
            // build a new snapshot for this account
            def snapshot = new Snapshot (account:account, amount:account.currentMonthSold, previous:account.lastSnapshot);
            account.addToSnapshots(snapshot)

            account.save()
        }
    }
}
