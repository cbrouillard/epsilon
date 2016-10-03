
def ENV_NAME = "EPSILON_CONF"
def props = new Properties()
String home = System.getProperty("user.home");
String confFilePath = home+ "/.epsilon.properties"
if(System.getenv(ENV_NAME)) {
    confFilePath = System.getenv(ENV_NAME);
}

try {
    InputStream is = new BufferedInputStream(new FileInputStream(confFilePath))
    props.load(is)
    is.close()
} catch (Exception e){
    println "FATAL ERROR : epsilon.properties does not exist or EPSILON_CONF env has not been defined."
}

dataSource {
    pooled = true
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
    singleSession = true
    //flush.mode = 'manual'
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
