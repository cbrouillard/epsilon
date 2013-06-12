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

public enum CategoryType {

    DEPENSE,
    REVENU,
    VIREMENT,
    ;

    public static CategoryType guess (String from){
        if (from.equals("depot")){
            return REVENU;
        }

        if (from.equals("facture")){
            return DEPENSE;
        }

        if (from.equals("virement")){
            return VIREMENT;
        }

        return DEPENSE;
    }

}
