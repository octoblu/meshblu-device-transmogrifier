_ = require 'lodash'
class MeshbluDeviceTransmogrifier
  constructor: (oldDevice) ->
    @device = _.clone oldDevice
    @device.meshblu = _.cloneDeep oldDevice.meshblu

  transmogrify: (device) =>
    return @device if _.get(@device, 'meshblu.version') == '2.0.0'
    _.set @device, 'meshblu.version', '2.0.0'

    @_migrateConfigureWhitelist()
    @_migrateConfigureAsWhitelist()
    @_migrateDiscoverWhitelist()
    @_migrateDiscoverAsWhitelist()
    @_migrateReceiveWhitelist()
    @_migrateReceiveAsWhitelist()
    @_migrateSendWhitelist()
    @_migrateSendAsWhitelist()
    @_migrateOwner()

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

  _migrateDiscoverAsWhitelist: =>
    _.each @device.discoverAsWhitelist, (uuid) =>
      _.set @device, "meshblu.whitelists.discover.as.#{uuid}", {}

    delete @device.discoverAsWhitelist

  _migrateOwner: =>
    return unless @device.owner?
    owner = @device.owner
    _.set @device, "meshblu.whitelists.broadcast.received.#{owner}", {}
    _.set @device, "meshblu.whitelists.broadcast.sent.#{owner}", {}

    _.set @device, "meshblu.whitelists.configure.as.#{owner}", {}
    _.set @device, "meshblu.whitelists.configure.sent.#{owner}", {}
    _.set @device, "meshblu.whitelists.configure.received.#{owner}", {}
    _.set @device, "meshblu.whitelists.configure.update.#{owner}", {}

    _.set @device, "meshblu.whitelists.discover.as.#{owner}", {}
    _.set @device, "meshblu.whitelists.discover.view.#{owner}", {}

    _.set @device, "meshblu.whitelists.message.as.#{owner}", {}
    _.set @device, "meshblu.whitelists.message.from.#{owner}", {}
    _.set @device, "meshblu.whitelists.message.sent.#{owner}", {}
    _.set @device, "meshblu.whitelists.message.received.#{owner}", {}

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

  _migrateSendAsWhitelist: =>
    _.each @device.sendAsWhitelist, (uuid) =>
      _.set @device, "meshblu.whitelists.message.as.#{uuid}", {}

    delete @device.sendAsWhitelist

  _migrateConfigureAsWhitelist: =>
    _.each @device.configureAsWhitelist, (uuid) =>
      _.set @device, "meshblu.whitelists.configure.as.#{uuid}", {}

    delete @device.configureAsWhitelist

module.exports = MeshbluDeviceTransmogrifier
