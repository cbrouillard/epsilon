package com.headbangers.epsilon.mobile

import com.headbangers.epsilon.*

class MobileCategory {
    String id
    String name
    String type

    String description
    String color

    public MobileCategory (dCategory){
        this.id = dCategory.id
        this.name = dCategory.name
        this.type = dCategory.type.name()
        this.description = dCategory.description
        this.color = dCategory.color
    }
}

