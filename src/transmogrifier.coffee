_ = require 'lodash'
class MeshbluDeviceTransmogrifier
  constructor: (oldDevice) ->
    throw new Error('Someone tried to transmogrify an undefined device! Stop doing that.') unless oldDevice?
    @device = _.clone oldDevice
    @device.meshblu = _.cloneDeep oldDevice.meshblu

  transmogrify: =>
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
    newWhitelist = _.map @device.configureWhitelist, (uuid) => {uuid}
    _.set @device, "meshblu.whitelists.configure.update", newWhitelist

    delete @device.configureWhitelist

  _migrateDiscoverWhitelist: =>
    newWhitelist = _.map @device.discoverWhitelist, (uuid) => {uuid}
    _.set @device, "meshblu.whitelists.discover.view", newWhitelist
    _.set @device, "meshblu.whitelists.configure.sent", newWhitelist

    delete @device.discoverWhitelist

  _migrateDiscoverAsWhitelist: =>
    newWhitelist = _.map @device.discoverAsWhitelist, (uuid) => {uuid}
    _.set @device, "meshblu.whitelists.discover.as", newWhitelist

    delete @device.discoverAsWhitelist

  _migrateOwner: =>
    return unless @device.owner?
    owner = @device.owner
    _.set @device, "meshblu.whitelists.broadcast.received", newWhitelist
    _.set @device, "meshblu.whitelists.broadcast.sent", newWhitelist

    _.set @device, "meshblu.whitelists.configure.as", newWhitelist
    _.set @device, "meshblu.whitelists.configure.sent", newWhitelist
    _.set @device, "meshblu.whitelists.configure.received", newWhitelist
    _.set @device, "meshblu.whitelists.configure.update", newWhitelist

    _.set @device, "meshblu.whitelists.discover.as", newWhitelist
    _.set @device, "meshblu.whitelists.discover.view", newWhitelist

    _.set @device, "meshblu.whitelists.message.as", newWhitelist
    _.set @device, "meshblu.whitelists.message.from", newWhitelist
    _.set @device, "meshblu.whitelists.message.sent", newWhitelist
    _.set @device, "meshblu.whitelists.message.received", newWhitelist

  _migrateReceiveWhitelist: =>
    newWhitelist = _.map @device.receiveWhitelist, (uuid) => {uuid}
    _.set @device, "meshblu.whitelists.broadcast.sent", newWhitelist

    delete @device.receiveWhitelist

  _migrateReceiveAsWhitelist: =>
    newWhitelist = _.map @device.receiveAsWhitelist, (uuid) => {uuid}
    _.set @device, "meshblu.whitelists.message.received", newWhitelist
    _.set @device, "meshblu.whitelists.broadcast.received", newWhitelist

    delete @device.receiveAsWhitelist

  _migrateSendWhitelist: =>
    newWhitelist = _.map @device.sendWhitelist, (uuid) => {uuid}
    _.set @device, "meshblu.whitelists.message.from", newWhitelist

    delete @device.sendWhitelist

  _migrateSendAsWhitelist: =>
    newWhitelist = _.map @device.sendAsWhitelist, (uuid) => {uuid}
    _.set @device, "meshblu.whitelists.message.as", newWhitelist

    delete @device.sendAsWhitelist

  _migrateConfigureAsWhitelist: =>
    newWhitelist = _.map @device.configureAsWhitelist, (uuid) => {uuid}
    _.set @device, "meshblu.whitelists.configure.as", newWhitelist

    delete @device.configureAsWhitelist

module.exports = MeshbluDeviceTransmogrifier
