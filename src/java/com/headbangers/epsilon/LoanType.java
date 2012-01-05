package com.headbangers.epsilon;

/**
 *
 * @author cyril
 */
public enum LoanType {

    ME_TO_US("+"),
    US_TO_ME("-");

    private LoanType(String sign) {
        this.sign = sign;
    }
    
    private String sign;

    public String getSign() {
        return sign;
    }
    
}
