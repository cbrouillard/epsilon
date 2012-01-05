
// export EPSILON_DATASOURCE=/home/cyril/epsilon.properties
def ENV_NAME = "EPSILON_CONF"
def props = new Properties()
if(System.getenv(ENV_NAME)) {
    InputStream is = new BufferedInputStream(new FileInputStream(System.getenv(ENV_NAME)))
    props.load(is)
    is.close()    
}

dataSource {
    pooled = true
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            driverClassName = props.get("datasource.driverClassName")
            username = props.get("datasource.username")
            password = props.get("datasource.password")
            dbCreate = props.get("datasource.dbCreate")
            url = props.get("datasource.url")
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:hsqldb:mem:testDb"
        }
    }
    production {
        //        dataSource {
        //            dbCreate = "update"
        //            url = "jdbc:hsqldb:file:prodDb;shutdown=true"
        //        }
        dataSource {
            driverClassName = props.get("datasource.driverClassName")
            username = props.get("datasource.username")
            password = props.get("datasource.password")
            dbCreate = props.get("datasource.dbCreate")
            url = props.get("datasource.url")
        }
    }
}