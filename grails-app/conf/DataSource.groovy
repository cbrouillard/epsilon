
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
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
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
            url = "jdbc:h2:mem:testDb;MVCC=TRUE"
        }
    }
    production {
        dataSource {
            driverClassName = props.get("datasource.driverClassName")
            username = props.get("datasource.username")
            password = props.get("datasource.password")
            dbCreate = props.get("datasource.dbCreate")
            url = props.get("datasource.url")
        }
    }
}
