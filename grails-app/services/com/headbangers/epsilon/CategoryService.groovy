package com.headbangers.epsilon

class CategoryService {

    boolean transactional = true
    def sessionFactory
    def dateUtil

    def  springSecurityService

    def findAllCategoriesByType (person, categoryType){
        return Category.createCriteria ().list {
            owner{eq("id", person.id)}
            if (categoryType) eq("type", categoryType)
        }
    }

    def buildColor (catName){
        def md5 = springSecurityService.encodePassword(catName).toString()
        return "#${md5.substring(0,6)}"
    }

    def findOrCreateCategory(person, categoryName, categoryType) {

        def category = Category.findByOwnerAndName (person, categoryName)
        if (!category){
            log.debug ("Creating a new Category : ${categoryName}")
            return new Category (name:categoryName, type:categoryType, owner:person, color:buildColor(categoryName)).save(flush:true);
        }
        return category
    }

    def retrieveOperations (forCategory){
        return Operation.createCriteria().list (order:'asc', sort:'dateApplication'){
            category{
                eq ("id", forCategory.id)
            }
        }
    }

    def sumDepenseForEachMonth (monthStart, monthEnd, forCategory){
        List<Integer> sums = new ArrayList<Integer> ()

        log.info "Category : ${forCategory.name}"
        while (monthStart <= monthEnd){

            def firstDate = dateUtil.getFirstDayOfTheMonth (monthStart)
            def lastDate = dateUtil.getLastDayOfTheMonth(monthStart)
            log.info "Intervalle de dates : du ${firstDate} au ${lastDate}"

            def session = sessionFactory.getCurrentSession()
            def sql =
        """
        select sum(O.amount)
        from category C inner join operation O on O.category_id = C.id
        where C.id = '${forCategory.id}'
        and (O.date_application between '${firstDate}' and '${lastDate}')
        and (O.type = 'RETRAIT' or O.type = 'VIREMENT_MOINS' or O.type = 'FACTURE')
        """
            def sumForMonth = session.createSQLQuery(sql)?.list().get(0)

            log.info "SQL : ${sql}"
            log.info "Pour le mois ${monthStart} , la somme = ${sumForMonth}"
            sums.add (sumForMonth?sumForMonth:0)
            monthStart ++
        }

        return sums
    }
    
    def sumRevenueForEachMonth (monthStart, monthEnd, forCategory){
        List<Integer> sums = new ArrayList<Integer> ()

        log.info "Category : ${forCategory.name}"
        while (monthStart <= monthEnd){

            def firstDate = dateUtil.getFirstDayOfTheMonth (monthStart)
            def lastDate = dateUtil.getLastDayOfTheMonth(monthStart)
            log.info "Intervalle de dates : du ${firstDate} au ${lastDate}"

            def session = sessionFactory.getCurrentSession()
            def sql =
        """
        select sum(O.amount)
        from category C inner join operation O on O.category_id = C.id
        where C.id = '${forCategory.id}'
        and (O.date_application between '${firstDate}' and '${lastDate}')
        and (O.type = 'DEPOT' or O.type = 'VIREMENT_PLUS')
        """
            def sumForMonth = session.createSQLQuery(sql)?.list().get(0)

            log.info "SQL : ${sql}"
            log.info "Pour le mois ${monthStart} , la somme = ${sumForMonth}"
            sums.add (sumForMonth?sumForMonth:0)
            monthStart ++
        }

        return sums
    }
}
