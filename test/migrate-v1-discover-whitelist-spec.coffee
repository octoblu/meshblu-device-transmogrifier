_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating discoverWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        discoverWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.discover.view).to.have.same.keys ['a']
      expect(@transmogrifiedDevice.meshblu.whitelists.configure.sent).to.have.same.keys ['a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.discoverWhitelist).not.to.exist
