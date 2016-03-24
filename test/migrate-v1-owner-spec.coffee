_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating the owner', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        owner: 'a'

      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should add the owner to all the whitelists', ->
      expectedWhitelists =
         broadcast:
            received: a: {}
            sent: a: {}
          discover:
            view: a: {}
            as: a: {}
          configure:
            update: a: {}
            as: a: {}
            sent: a: {}
            received: a: {}
          message:
            from: a: {}
            as: a: {}
            sent: a: {}
            received: a: {}
      expect(@transmogrifiedDevice.meshblu.whitelists).to.deep.equal expectedWhitelists

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.configureAsWhitelist).not.to.exist
