_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

beforeEach ->
  @sut = new MeshbluDeviceTransmogrifier

describe 'migrating receiveWhitelist', ->
  context 'with an unknown version', ->
    beforeEach ->
      @device =
        receiveWhitelist: ['a']
      @transmogrifiedDevice = @sut.transmogrify @device

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.broadcast.sent).to.have.same.keys ['a']

    it 'should remove old whitelists', ->
      expect(@transmogrifiedDevice.receiveWhitelist).not.to.exist

  context 'with two devices', ->
    beforeEach ->
      @device =
        receiveWhitelist: ['a', 'b']
      @transmogrifiedDevice = @sut.transmogrify @device

    it 'should create the correct meshblu.whitelists.broadcast', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.broadcast.sent).to.have.same.keys ['a', 'b']

  context 'with two different devices', ->
    beforeEach ->
      @device =
        receiveWhitelist: ['c', 'd']
      @transmogrifiedDevice = @sut.transmogrify @device

    it 'should create the correct whitelist', ->
      expect(@transmogrifiedDevice.meshblu.whitelists.broadcast.sent).to.have.same.keys ['c', 'd']
