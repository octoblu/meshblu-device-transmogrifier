_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating discoverAsWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        discoverAsWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.discover.as).to.have.same.keys ['a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.discoverAsWhitelist).not.to.exist
