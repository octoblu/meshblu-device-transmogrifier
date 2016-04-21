_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'migrating sendAsWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        sendAsWhitelist: ['a']
      @sut = new MeshbluDeviceTransmogrifier @device
      @transmogrifiedDevice = @sut.transmogrify()

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.message.as).to.containSubset [uuid: 'a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.sendAsWhitelist).not.to.exist
