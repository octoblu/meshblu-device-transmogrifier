_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating configureWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        configureWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.configure.update).to.have.same.keys ['a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.configureWhitelist).not.to.exist
