_ = require 'lodash'
class MeshbluDeviceTransmogrifier
  transmogrify: (device) =>
    return device if _.get(device, 'meshblu.version') == '2.0.0'
    newDevice = _.omit device, ['receiveWhitelist']

    _.each device.receiveWhitelist, (uuid) =>
      _.set newDevice, "meshblu.whitelists.broadcast.sent.#{uuid}", {}

    _.each device.discoverWhitelist, (uuid) =>
      _.set newDevice, "meshblu.whitelists.discover.view.#{uuid}", {}

    return newDevice

module.exports = MeshbluDeviceTransmogrifier
