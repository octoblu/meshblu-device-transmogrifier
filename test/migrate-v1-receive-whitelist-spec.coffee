_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating receiveWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        receiveWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.broadcast.sent).to.containSubset [uuid: 'a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.receiveWhitelist).not.to.exist
