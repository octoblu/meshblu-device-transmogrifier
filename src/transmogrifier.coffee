_ = require 'lodash'
class MeshbluDeviceTransmogrifier
  constructor: (oldDevice) ->
    @device = _.clone oldDevice
    @device.meshblu = _.cloneDeep oldDevice.meshblu

  transmogrify: (device) =>
    return @device if _.get(@device, 'meshblu.version') == '2.0.0'
    _.set @device, 'meshblu.version', '2.0.0'

    @_migrateConfigureWhitelist()
    @_migrateDiscoverWhitelist()
    @_migrateReceiveWhitelist()
    @_migrateReceiveAsWhitelist()
    @_migrateSendWhitelist()

    return @device

  _migrateConfigureWhitelist: =>
    _.each @device.configureWhitelist, (uuid) =>
      _.set @device, "meshblu.whitelists.configure.update.#{uuid}", {}

    delete @device.configureWhitelist

  _migrateDiscoverWhitelist: =>
    _.each @device.discoverWhitelist, (uuid) =>
      _.set @device, "meshblu.whitelists.discover.view.#{uuid}", {}
      _.set @device, "meshblu.whitelists.configure.sent.#{uuid}", {}

    delete @device.discoverWhitelist

  _migrateReceiveWhitelist: =>
    _.each @device.receiveWhitelist, (uuid) =>
      _.set @device, "meshblu.whitelists.broadcast.sent.#{uuid}", {}

    delete @device.receiveWhitelist

  _migrateReceiveAsWhitelist: =>
    _.each @device.receiveAsWhitelist, (uuid) =>
      _.set @device, "meshblu.whitelists.message.received.#{uuid}", {}
      _.set @device, "meshblu.whitelists.broadcast.received.#{uuid}", {}

    delete @device.receiveAsWhitelist

  _migrateSendWhitelist: =>
    _.each @device.sendWhitelist, (uuid) =>
      _.set @device, "meshblu.whitelists.message.from.#{uuid}", {}

    delete @device.sendWhitelist

module.exports = MeshbluDeviceTransmogrifier
