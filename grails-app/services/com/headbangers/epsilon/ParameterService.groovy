package com.headbangers.epsilon

class ParameterService {

    private Parameter findParameter (Person person, String name) {
        def parameterToReturn = null
        person.parameters.each{ zeParameter ->
            
            if (zeParameter.name.equals(name)){
                parameterToReturn = zeParameter
                return parameterToReturn
            }
        }
        
        return parameterToReturn
    }  
    
    public void setBayesianFilterParameter (Person person, boolean value){
        def zeParameter = this.findParameter (person, "bayesian_filter")
        log.error "Parameter = ${zeParameter}"
        
        zeParameter.value = "${value}"
        zeParameter.save(flush:true)
    }
    
    public String getBayesianFilterParameter (Person person){
        def zeParameter = this.findParameter (person, "bayesian_filter")
        log.debug "Parameter = ${zeParameter}"
        return zeParameter?.value        
    }
    
    
}
