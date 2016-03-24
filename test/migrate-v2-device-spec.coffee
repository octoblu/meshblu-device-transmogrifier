_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

beforeEach ->
  @sut = new MeshbluDeviceTransmogrifier

describe 'a device with data', ->
  beforeEach ->
    @device =
      other: true
    @transmogrifiedDevice = @sut.transmogrify @device

  it 'should preserve existing data', ->
    expect(@transmogrifiedDevice.other).to.be.true

describe 'migrating a v2 device', ->
  beforeEach ->
    @device =
      discoverWhitelist: ['b']
      meshblu:
        version: '2.0.0'

    @transmogrifiedDevice = @sut.transmogrify @device

  it 'should do nothing', ->
    expect(@transmogrifiedDevice).to.deep.equal @device
