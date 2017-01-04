package com.headbangers.epsilon

class Document {

    public enum Type {
        INVOICE("operation", "operation.png", "linkto_operation", "[\"pdf\"]"),
        BANK ("bank", "bank.png", "linkto_bank", "[\"pdf\"]"),
        ACCOUNT("account", "account.png", "linkto_account", "[\"pdf\", \"ofx\", \"qif\", \"csv\"]");

        private String controllerName;
        private String linkView;
        private String icon;
        private String allowed;

        private Type (String cName, String i, String lV, String allowed){
            this.controllerName = cName
            this.icon = i
            this.linkView = lV
            this.allowed = allowed
        }

        String getControllerName() {
            return controllerName
        }

        String getIcon() {
            return icon
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
