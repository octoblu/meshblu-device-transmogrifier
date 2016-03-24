_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating receiveAsWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        receiveAsWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.message.received).to.have.same.keys ['a']
      expect(@transmogrifiedDevice.meshblu.whitelists.broadcast.received).to.have.same.keys ['a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.receiveAsWhitelist).not.to.exist
