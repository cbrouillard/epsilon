package com.headbangers.epsilon



import org.junit.*
import grails.test.mixin.*

@TestFor(WishController)
@Mock(Wish)
class WishControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/wish/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.wishInstanceList.size() == 0
        assert model.wishInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.wishInstance != null
    }

    void testSave() {
        controller.save()

        assert model.wishInstance != null
        assert view == '/wish/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/wish/show/1'
        assert controller.flash.message != null
        assert Wish.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/wish/list'


        populateValidParams(params)
        def wish = new Wish(params)

        assert wish.save() != null

        params.id = wish.id

        def model = controller.show()

        assert model.wishInstance == wish
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/wish/list'


        populateValidParams(params)
        def wish = new Wish(params)

        assert wish.save() != null

        params.id = wish.id

        def model = controller.edit()

        assert model.wishInstance == wish
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/wish/list'

        response.reset()


        populateValidParams(params)
        def wish = new Wish(params)

        assert wish.save() != null

        // test invalid parameters in update
        params.id = wish.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/wish/edit"
        assert model.wishInstance != null

        wish.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/wish/show/$wish.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        wish.clearErrors()

        populateValidParams(params)
        params.id = wish.id
        params.version = -1
        controller.update()

        assert view == "/wish/edit"
        assert model.wishInstance != null
        assert model.wishInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/wish/list'

        response.reset()

        populateValidParams(params)
        def wish = new Wish(params)

        assert wish.save() != null
        assert Wish.count() == 1

        params.id = wish.id

        controller.delete()

        assert Wish.count() == 0
        assert Wish.get(wish.id) == null
        assert response.redirectedUrl == '/wish/list'
    }
}
