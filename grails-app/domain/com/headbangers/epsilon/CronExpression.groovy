package com.headbangers.epsilon

import java.text.ParseException

class CronExpression {

    String name
    String expression

    static constraints = {
    }

    String validate (){
        try {
            new org.quartz.CronExpression(this.expression)
        } catch (ParseException e){
            return e.getMessage()
        }
        return "Expression OK"
    }

    boolean validateProperly (){
        try {
            new org.quartz.CronExpression(this.expression)
        } catch (ParseException e){
            return false
        }
        return true
    }

    Date getNextDate (){
        org.quartz.CronExpression runExpr = new org.quartz.CronExpression(this.expression)
        return runExpr.getNextValidTimeAfter(new Date())
    }

    List<Date> getNextDates (int nb){
        org.quartz.CronExpression runExpr = new org.quartz.CronExpression(this.expression)
        List<Date> dates = new ArrayList<>()
        Date running = new Date()
        for (int i = 0; i < nb; i++ ){
            dates.add(runExpr.getNextValidTimeAfter(running))
            running = runExpr.getNextValidTimeAfter(running)
        }
        return dates
    }
}
