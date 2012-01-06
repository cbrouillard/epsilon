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
