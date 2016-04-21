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
      expect(@transmogrifiedDevice.meshblu.whitelists.message.received).to.containSubset [uuid: 'a']
      expect(@transmogrifiedDevice.meshblu.whitelists.broadcast.received).to.containSubset [uuid: 'a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.receiveAsWhitelist).not.to.exist
