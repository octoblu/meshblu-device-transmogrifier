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
            received: [uuid: 'a']
            sent: [uuid: 'a']
          discover:
            view: [uuid: 'a']
            as: [uuid: 'a']
          configure:
            update: [uuid: 'a']
            as: [uuid: 'a']
            sent: [uuid: 'a']
            received: [uuid: 'a']
          message:
            from: [uuid: 'a']
            as: [uuid: 'a']
            sent: [uuid: 'a']
            received: [uuid: 'a']

      expect(@transmogrifiedDevice.meshblu.whitelists).to.deep.equal expectedWhitelists

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.configureAsWhitelist).not.to.exist
