_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating configureAsWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        configureAsWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.configure.as).to.have.same.keys ['a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.configureAsWhitelist).not.to.exist
