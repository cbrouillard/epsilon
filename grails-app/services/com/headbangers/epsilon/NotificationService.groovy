package com.headbangers.epsilon
import org.springframework.mail.MailSendException

class NotificationService {

    boolean transactional = true

    def mailService

    def sendScheduledDoneMail(person, scheduledList) {

        this.sendMyMail (person.email, "no-reply@chiptunes.fr", "[EPSILON] Opérations automatiques effectuées",
        "/mail/scheduled", scheduledList)
        
    }


    private boolean sendMyMail (toMail, fromMail, subjectMail, view, bodyMail){
        try{
            mailService.sendMail {
                to toMail
                from fromMail
                subject subjectMail
                body( view:view , model:[mail:bodyMail,to:toMail,from:fromMail,subject:subjectMail])
            }
            return true
        }catch (MailSendException e){
            log.fatal ("Impossible d'envoyer le mail",e)
            return false
        }
    }
}
