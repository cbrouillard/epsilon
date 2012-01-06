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
