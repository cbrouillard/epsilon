class UrlMappings {
    static mappings = {
       
        "/operation/$account?/list"{
            controller = "operation"
            action = "list"
        }

        "/category/autocomplete/$type"{
            controller = "category"
            action = "autocomplete"
        }

        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }
      
        "/index.gsp"{
            controller = "summary"
        }
        "/"{
            controller = "summary"
        }
	"500"(view:'/error')
    }
}
