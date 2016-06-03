_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating configureWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        configureWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()
      console.log("transmogrifiedDevice", @transmogrifiedDevice)

    it 'should create the correct configure.update whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.configure.update).to.containSubset [uuid: 'a']

    it 'should create the correct message.received whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.message.received).to.containSubset [uuid: 'a']

    it 'should create the correct message.sent whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.message.sent).to.containSubset [uuid: 'a']

    it 'should create the correct message.sent whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.broadcast.received).to.containSubset [uuid: 'a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.configureWhitelist).not.to.exist
