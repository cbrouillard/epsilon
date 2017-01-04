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

grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {
        grailsPlugins()
        grailsHome()
        grailsCentral()
        mavenLocal()
        mavenCentral()
    
        mavenRepo "http://repo.grails.org/grails/repo/"

        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
        //runtime 'mysql:mysql-connector-java:5.1.5'
        runtime 'postgresql:postgresql:9.1-901.jdbc4'
        compile 'org.jsoup:jsoup:1.9.2'
        //runtime 'org.springframework:spring-aop:4.0.5.RELEASE'
        //runtime 'org.springframework:spring-expression:4.0.5.RELEASE'
        test 'org.hamcrest:hamcrest-core:1.3'
    }

    plugins {

        runtime ":hibernate:3.6.10.15"
        build ":tomcat:7.0.54"

        runtime ":resources:1.2.8"
        //compile ':asset-pipeline:1.8.11'
        //compile ':cache:1.1.7'

        compile ":spring-security-core:2.0.0"

        compile ":quartz:1.0.2"
        compile ":mail:1.0.7"

        compile ":multi-select:0.2"
        runtime "org.grails.plugins:cors:1.1.8"
        compile ":jquery-ui:1.10.4"
        runtime ":jquery:1.11.1"
        runtime ":webxml:1.4.1"
        compile ":twitter-bootstrap:3.3.2.1"
        compile ":google-visualization:1.0.2"
    }

}
