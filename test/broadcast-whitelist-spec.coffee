_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

beforeEach ->
  @sut = new MeshbluDeviceTransmogrifier

describe 'migrating receiveWhitelist', ->
  context 'with one device', ->
    beforeEach ->
      @device =
        receiveWhitelist: ['a']
      @device2 = @sut.transmogrify @device

    it 'should create meshblu.whitelists.broadcast', ->
      expect(@device2.meshblu.whitelists.broadcast.sent).to.have.same.keys ['a']

  context 'with two devices', ->
    beforeEach ->
      @device =
        receiveWhitelist: ['a', 'b']
      @device2 = @sut.transmogrify @device

    it 'should create meshblu.whitelists.broadcast', ->
      expect(@device2.meshblu.whitelists.broadcast.sent).to.have.same.keys ['a', 'b']

  context 'with two different devices', ->
    beforeEach ->
      @device =
        receiveWhitelist: ['c', 'd']
      @device2 = @sut.transmogrify @device

    it 'should create meshblu.whitelists.broadcast', ->
      expect(@device2.meshblu.whitelists.broadcast.sent).to.have.same.keys ['c', 'd']
