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

  _addToList: (device, listName, record) =>
    list = _.get device, listName
    list = [] unless _.isArray list
    list = _.unionBy list, [record], 'uuid'
    _.set device, listName, list

  _migrateConfigureWhitelist: =>
    _.each @device.configureWhitelist, (uuid) =>
      @_addToList @device, 'meshblu.whitelists.configure.update', {uuid}

      @_addToList @device, 'meshblu.whitelists.broadcast.received', {uuid}
      @_addToList @device, 'meshblu.whitelists.message.sent', {uuid}
      @_addToList @device, 'meshblu.whitelists.message.received', {uuid}

    delete @device.configureWhitelist

  _migrateDiscoverWhitelist: =>
    _.each @device.discoverWhitelist, (uuid) =>
      @_addToList @device, "meshblu.whitelists.discover.view", {uuid}
      @_addToList @device, "meshblu.whitelists.configure.sent", {uuid}

    delete @device.discoverWhitelist

  _migrateDiscoverAsWhitelist: =>
    _.each @device.discoverAsWhitelist, (uuid) =>
      @_addToList @device, "meshblu.whitelists.discover.as", {uuid}

    delete @device.discoverAsWhitelist

  _migrateOwner: =>
    return unless @device.owner?
    owner = {uuid: @device.owner}

    @_addToList @device, 'meshblu.whitelists.broadcast.received', owner
    @_addToList @device, 'meshblu.whitelists.broadcast.sent', owner

    @_addToList @device, 'meshblu.whitelists.configure.as', owner
    @_addToList @device, 'meshblu.whitelists.configure.sent', owner
    @_addToList @device, 'meshblu.whitelists.configure.received', owner
    @_addToList @device, 'meshblu.whitelists.configure.update', owner

    @_addToList @device, 'meshblu.whitelists.discover.as', owner
    @_addToList @device, 'meshblu.whitelists.discover.view', owner

    @_addToList @device, 'meshblu.whitelists.message.as', owner
    @_addToList @device, 'meshblu.whitelists.message.from', owner
    @_addToList @device, 'meshblu.whitelists.message.sent', owner
    @_addToList @device, 'meshblu.whitelists.message.received', owner

  _migrateReceiveWhitelist: =>
    _.each @device.receiveWhitelist, (uuid) =>
      @_addToList @device, "meshblu.whitelists.broadcast.sent", {uuid}

    delete @device.receiveWhitelist

  _migrateReceiveAsWhitelist: =>
    _.each @device.receiveAsWhitelist, (uuid) =>
      @_addToList @device, "meshblu.whitelists.message.received", {uuid}
      @_addToList @device, "meshblu.whitelists.broadcast.received", {uuid}

    delete @device.receiveAsWhitelist

  _migrateSendWhitelist: =>
    _.each @device.sendWhitelist, (uuid) =>
      @_addToList @device, "meshblu.whitelists.message.from", {uuid}

    delete @device.sendWhitelist

  _migrateSendAsWhitelist: =>
    _.each @device.sendAsWhitelist, (uuid) =>
      @_addToList @device, "meshblu.whitelists.message.as", {uuid}

    delete @device.sendAsWhitelist

  _migrateConfigureAsWhitelist: =>
    _.each @device.configureAsWhitelist, (uuid) =>
      @_addToList @device, "meshblu.whitelists.configure.as", {uuid}

    delete @device.configureAsWhitelist

module.exports = MeshbluDeviceTransmogrifier
