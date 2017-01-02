package com.headbangers.epsilon

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class DocumentController {

    def springSecurityService
    def genericService

    def invoices() {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        def person = springSecurityService.getCurrentUser()
        def documents = Document.createCriteria().list {
            owner { eq("id", person.id) }
            eq("type", Document.Type.INVOICE)
        }

        render(view: 'list', model: [documents: documents, type: Document.Type.INVOICE])
    }

    def banks (){

    }

    def accounts (){

    }

    def create() {
        if (!params.type) {
            redirect(action: 'invoices')
            return
        }

        def type = Document.Type.valueOf(params.type)
        Document document = new Document(type: type)

        return [document: document]
    }

    def save (){
        def person = springSecurityService.getCurrentUser()
        Document document = new Document(params)
        document.owner = person

        MultipartFile file = request.getFile("data")
        if (file){
            if (!document.name) {
                document.name = file.getOriginalFilename()
            }

            document.data = file.getBytes()
        }

        if (document.validate() && document.save(flush:true)){
            flash.message = "Document créé"
            redirect(action: "${document.type.toString().toLowerCase()}s")
        } else {
            render view: 'create', model: [document: document]
        }
    }

    def download (){
        def person = springSecurityService.getCurrentUser()
        Document document = Document.findByIdAndOwner(params.id, person)

        if (document){
            response.setContentType("application/pdf")
            response.setHeader("Content-disposition", "attachment;filename=\"${document.name}\"")
            response.setHeader("Content-Length", "${document.data.size()}")
            response.outputStream << document.data
        }else {
            redirect(action: 'invoices')
        }
    }
}
