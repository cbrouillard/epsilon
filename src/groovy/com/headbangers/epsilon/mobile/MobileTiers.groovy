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

package com.headbangers.epsilon.mobile

import com.headbangers.epsilon.Tiers

class MobileTiers {
    String id
    String name
    String description
    String color
    List<MobileOperation> operations

    public MobileTiers (Tiers dTiers){
        if (dTiers) {
            this.id = dTiers.id
            this.name = dTiers.name
            this.description = dTiers.description
            this.color = dTiers.color
        }
    }
}

