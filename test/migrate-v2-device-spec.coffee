_ = require 'lodash'
MeshbluDeviceTransmogrifier = require '../'

describe 'a device with data', ->
  beforeEach ->
    @device =
      other: true
    @sut = new MeshbluDeviceTransmogrifier @device
    @transmogrifiedDevice = @sut.transmogrify()

  it 'should preserve existing data', ->
    expect(@transmogrifiedDevice.other).to.be.true

  it 'should set the version to 2.0.0', ->
    expect(@transmogrifiedDevice.meshblu.version).to.equal '2.0.0'

describe 'migrating a v2 device', ->
  beforeEach ->
    @device =
      discoverWhitelist: ['b']
      meshblu:
        version: '2.0.0'

    @sut = new MeshbluDeviceTransmogrifier @device
    @transmogrifiedDevice = @sut.transmogrify()

  it 'should do nothing', ->
    expect(@transmogrifiedDevice).to.deep.equal @device
