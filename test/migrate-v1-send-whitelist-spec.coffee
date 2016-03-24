_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating sendWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        sendWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.message.from).to.have.same.keys ['a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.sendWhitelist).not.to.exist
