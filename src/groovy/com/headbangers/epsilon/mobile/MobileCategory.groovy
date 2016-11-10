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

import com.headbangers.epsilon.*

class MobileCategory {
    String id
    String name
    String type

    String description
    String color
    List<MobileOperation> operations

    public MobileCategory(dCategory) {
        if (dCategory) {
            this.id = dCategory.id
            this.name = dCategory.name
            this.type = dCategory.type.name()
            this.description = dCategory.description
            this.color = dCategory.color
        }
    }


}

