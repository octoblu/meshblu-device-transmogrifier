_ = require 'lodash'
class MeshbluDeviceTransmogrifier
  transmogrify: (device) =>
    newDevice = {}

    _.each device.receiveWhitelist, (uuid) =>
      _.set newDevice, "meshblu.whitelists.broadcast.sent.#{uuid}", {}

    return newDevice

module.exports = MeshbluDeviceTransmogrifier
