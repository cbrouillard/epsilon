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

    def mailService

    def sendScheduledDoneMail(person, scheduledList) {

        Map<String, List<Scheduled>> emailScheduleds = new HashMap<>()

        Map<String, List<Scheduled>> joinedScheduled = [:]

        scheduledList.each { sc ->
            if (sc.accountTo?.joinOwner) {
                def joined = joinedScheduled.get(sc.accountTo.joinOwner.email)
                if (!joined) {
                    joined = []
                    joinedScheduled.put(sc.accountTo.joinOwner.email, joined)
                }
                joined.add(sc)

            } else if (sc.accountFrom?.joinOwner) {
                def joined = joinedScheduled.get(sc.accountFrom.joinOwner.email)
                if (!joined) {
                    joined = []
                    joinedScheduled.put(sc.accountFrom.joinOwner.email, joined)
                }
                joined.add(sc)
            }

        }

        this.sendMyMail(person.email, "no-reply@chiptunes.fr", "[EPSILON] Opérations automatiques effectuées",
                "/mail/scheduled", scheduledList)

        joinedScheduled.each { email, scs ->
            this.sendMyMail(email, "no-reply@chiptunes.fr", "[EPSILON] Opérations automatiques sur un compte joint effectuées",
                    "/mail/scheduled", scs)
        }
    }


    private boolean sendMyMail(toMail, fromMail, subjectMail, view, bodyMail) {
        try {
            mailService.sendMail {
                to toMail
                from fromMail
                subject subjectMail
                body(view: view, model: [mail: bodyMail, to: toMail, from: fromMail, subject: subjectMail])
            }
            return true
        } catch (MailSendException e) {
            log.fatal("Impossible d'envoyer le mail", e)
            return false
        } catch (Exception e) {
            log.fatal("Impossible d'envoyer le mail", e)
            return false
        }
    }
}
