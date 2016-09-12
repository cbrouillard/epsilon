package com.headbangers.epsilon

import java.text.ParseException

class CronExpression {

    String name
    String expression

    static constraints = {
    }

    String validate (){
        if (this.expression && this.expression.startsWith("E")){
            def split = this.expression.split(" ")
            if (split.size() < 3){
                return "Expression should have 3 parts"
            }

            def selector = split[1]
            if (! ( selector.equals("d") || selector.equals("m"))){
                return "Selector only accept 'd' or 'm' character"
            }

            try {
                new Integer(split[2])
            }catch (NumberFormatException e){
                return "Value is not a number"
            }

        } else {
            try {
                new org.quartz.CronExpression(this.expression)
            } catch (ParseException e) {
                return e.getMessage()
            }
        }
        return "Expression OK"
    }

    boolean validateProperly (){
        if (this.expression && this.expression.startsWith("E")){
            return this.validate().equals ("Expression OK")
        } else {
            try {
                new org.quartz.CronExpression(this.expression)
            } catch (ParseException e) {
                return false
            }
        }
        return true
    }

    Date getNextDate (){
        if (this.expression && this.expression.startsWith("E")){
            def split = this.expression.split(" ")
            def selector = split[1]
            def value = new Integer(split[2])

            Calendar cal = Calendar.getInstance()
            if (selector.equals("d")){
                cal.add(Calendar.DAY_OF_YEAR, value)
            } else if (selector.equals("m")){
                cal.add(Calendar.MONTH, value)
            }
            return cal.getTime()
        } else {
            org.quartz.CronExpression runExpr = new org.quartz.CronExpression(this.expression)
            return runExpr.getNextValidTimeAfter(new Date())
        }
    }

    List<Date> getNextDates (int nb){
        return getNextDates(nb, new Date())
    }

    List<Date> getNextDates (int nb, Date startingDate){
        List<Date> dates = new ArrayList<>()
        if (this.expression && this.expression.startsWith("E")){
            def split = this.expression.split(" ")
            def selector = split[1]
            def value = new Integer(split[2])

            Calendar cal = Calendar.getInstance()
            cal.setTime(startingDate)
            for (int i = 0; i < nb; i++) {
                if (selector.equals("d")){
                    cal.add(Calendar.DAY_OF_YEAR, value)
                } else if (selector.equals("m")){
                    cal.add(Calendar.MONTH, value)
                }
                dates.add(cal.getTime())
            }

        } else {
            org.quartz.CronExpression runExpr = new org.quartz.CronExpression(this.expression)

            Date running = startingDate
            for (int i = 0; i < nb; i++) {
                dates.add(runExpr.getNextValidTimeAfter(running))
                running = runExpr.getNextValidTimeAfter(running)
            }
        }
        return dates
    }
}
