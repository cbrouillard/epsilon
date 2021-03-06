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

class UrlMappings {
    static mappings = {

        "/operation/$account?/list" {
            controller = "operation"
            action = "list"
        }

        "/category/autocomplete/$type" {
            controller = "category"
            action = "autocomplete"
        }

        "/category/operationsChart/$id/$fromYear/$toYear" {
            controller = "category"
            action = "operationsChart"
        }

        "/tiers/operationsChart/$id/$fromYear/$toYear" {
            controller = "tiers"
            action = "operationsChart"
        }

        "/$controller/$action?/$id?" {
            constraints {
                // apply constraints here
            }
        }

        "/api/wishes"(resources: 'wsWish')
        "/api/accounts"(resources: 'wsAccount') {
            "/operations"(controller: 'wsAccount', action: 'operations')
        }
        "/api/accounts/$wsAccountId/default/$isDefault" {
            controller = 'wsAccount'
            action = "setDefault"
        }
        "/api/accounts/$wsAccountId/chart/future" {
            controller = "wsData"
            action = "chartAccountFuture"
        }
        "/api/budgets"(resources: 'wsBudget')
        "/api/budget/$wsBudgetId/chart/operations" {
            controller = "wsData"
            action = "chartBudgetOperations"
        }
        "/api/categories"(resources: 'wsCategory') {
            "/operations"(controller: 'wsCategory', action: 'operations')
        }
        "/api/categories/names" {
            controller = 'wsCategory'
            action = 'names'
        }
        "/api/categories/$wsCategoryId/chart/operations" {
            controller = "wsData"
            action = "chartCategoryOperations"
        }
        "/api/tiers"(resources: 'wsTiers') {
            "/operations"(controller: 'wsTiers', action: 'operations')
        }
        "/api/tiers/names" {
            controller = 'wsTiers'
            action = 'names'
        }
        "/api/tiers/$wsTiersId/chart/operations" {
            controller = "wsData"
            action = "chartTiersOperations"
        }
        "/api/operations"(resources: 'wsOperation') {
            "/e"(controller: "wsOperation", action: "editOperation")
        }
        "/api/accounts/$account/operations/spent" {
            controller = 'wsOperation'
            action = 'addDepense'
        }
        "/api/accounts/$account/operations/revenue" {
            controller = 'wsOperation'
            action = 'addRevenue'
        }
        "/api/accounts/$accountFrom/operations/transfer/$accountTo" {
            controller = 'wsOperation'
            action = 'addVirement'
        }
        "/api/scheduleds"(resources: 'wsScheduled')
        "/api/data/categorychart" {
            controller = 'wsData'
            action = 'chartByCategoryData'
        }
        "/api/data/soldstats" {
            controller = 'wsData'
            action = 'soldStats'
        }
        "/api/auth"(resources: 'wsAuth')


        "/index.gsp" {
            controller = "summary"
        }
        "/" {
            controller = "summary"
        }
        "500"(view: '/error')
    }
}
