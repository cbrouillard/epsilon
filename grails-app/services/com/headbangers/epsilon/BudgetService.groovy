package com.headbangers.epsilon

class BudgetService {

    def dateUtil

    def calculateOutOfBudgetAmount(List<Budget> budgets, Person connected) {
        Set<Category> involvedCategories = new HashSet<>()
        involvedCategories.addAll(budgets*.attachedCategories)

        Date firstDay = dateUtil.getDateAtMorning(dateUtil.getFirstDayOfTheMonth(new Date()))

        if (involvedCategories) {

            def categoriesId = involvedCategories*.id.flatten()

            if (categoriesId) {
                try {
                    def amount = Operation.createCriteria().get {
                        ge("dateApplication", firstDay)
                        eq("type", OperationType.RETRAIT)
                        eq("isFromScheduled", false)
                        owner {
                            eq("id", connected.id)
                        }
                        not {
                            category {
                                'in'("id", categoriesId)
                            }
                        }

                        projections {
                            sum("amount")
                        }
                    }
                    return amount ?: 0D
                } catch (Exception e) {
                    println e
                }
            }
        }

        return 0D
    }

    def retrieveOutOfBudgetOperations(List<Budget> budgets, Person connected) {
        Set<Category> involvedCategories = new HashSet<>()
        involvedCategories.addAll(budgets*.attachedCategories)

        Date firstDay = dateUtil.getDateAtMorning(dateUtil.getFirstDayOfTheMonth(new Date()))

        if (involvedCategories) {
            def operations = Operation.createCriteria().list {
                ge("dateApplication", firstDay)
                eq("type", OperationType.RETRAIT)
                not {
                    category {
                        'in'("id", involvedCategories*.id.flatten())
                    }
                }
                eq("isFromScheduled", false)
                owner {
                    eq("id", connected.id)
                }
                order("dateApplication", "desc")
            }

            return operations
        }

        return new ArrayList<Operation>()
    }

}
