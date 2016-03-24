_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

beforeEach ->
  @sut = new MeshbluDeviceTransmogrifier

describe 'migrating discoverWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        discoverWhitelist: ['a']
      @transmogrifiedDevice = @sut.transmogrify @device

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.discover.view).to.have.same.keys ['a']
