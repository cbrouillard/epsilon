package com.headbangers.epsilon

class Document {

    public enum Type {
        INVOICE("operation", "operation.png", "linkto_operation"),
        BANK ("bank", "bank.png", "linkto_bank"),
        ACCOUNT("account", "account.png", "linkto_account");

        private String controllerName;
        private String linkView;
        private String icon;

        private Type (String cName, String i, String lV){
            this.controllerName = cName
            this.icon = i
            this.linkView = lV
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
