package com.headbangers.epsilon;

public enum OperationType {

    RETRAIT("-"),
    DEPOT("+"),
    VIREMENT_PLUS("+"),
    VIREMENT_MOINS("-"),
    FACTURE("-"),
    VIREMENT("-"),
    ;

    private OperationType(String sign) {
        this.sign = sign;
    }

    private String sign;

    public String getSign() {
        return sign;
    }

}
