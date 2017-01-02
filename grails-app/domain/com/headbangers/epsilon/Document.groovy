package com.headbangers.epsilon

class Document {

    public enum Type {
        INVOICE, BANK, ACCOUNT
    }
    static belongsTo = [Operation, Bank, Account, Loan]

    String id
    String name
    Person owner
    Type type
    byte[] data

    static constraints = {
        name nullable: false, blank: false
        data maxSize: 1024 * 1024 * 10 // 10mb
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
