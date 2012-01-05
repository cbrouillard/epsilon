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
            def snapshot = new Snapshot (account:account, amount:account.sold, previous:account.lastSnapshot);
            account.addToSnapshots(snapshot)

            account.save()
        }
    }
}
