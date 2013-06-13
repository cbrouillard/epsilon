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

        "/index.gsp" {
            controller = "summary"
        }
        "/" {
            controller = "summary"
        }
        "500"(view: '/error')
    }
}
