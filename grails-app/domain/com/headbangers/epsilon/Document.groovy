package com.headbangers.epsilon

class Document {

    public enum Type {
        SALARY("operation", "linkto_operation", "[\"pdf\"]"),
        INVOICE("operation", "linkto_operation", "[\"pdf\"]"),
        BANK("bank", "linkto_bank", "[\"pdf\"]"),
        ACCOUNT("account", "linkto_account", "[\"pdf\", \"ofx\", \"qif\", \"csv\"]");

        private String controllerName;
        private String linkView;
        private String allowed;

        private Type(String cName, String lV, String allowed) {
            this.controllerName = cName
            this.linkView = lV
            this.allowed = allowed
        }

        String getControllerName() {
            return controllerName
        }

        String getLinkView() {
            return linkView
        }

        String getAllowed() {
            return allowed
        }
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
