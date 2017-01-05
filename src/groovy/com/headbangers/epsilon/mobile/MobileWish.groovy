package com.headbangers.epsilon.mobile

import com.headbangers.epsilon.Wish

class MobileWish {

    String id
    String name
    String description
    Double price
    String webShopUrl
    String thumbnailUrl
    boolean bought
    Date boughtDate
    Date previsionBuy
    String account
    String category

    public MobileWish (){}

    public MobileWish (Wish dWish){
        this.id = dWish.id
        this.name = dWish.name
        this.description = dWish.description
        this.price = dWish.price
        this.webShopUrl = dWish.webShopUrl
        this.thumbnailUrl = dWish.thumbnailUrl
        this.bought = dWish.bought
        this.boughtDate = dWish.boughtDate
        this.previsionBuy = dWish.previsionBuy
        this.account = dWish.account?.name
        this.category = dWish.category?.name
    }

}
