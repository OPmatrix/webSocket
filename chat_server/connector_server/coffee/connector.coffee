util = require 'util'
async = require 'async'

connectorServer = require './handler/connectorServer'
rpc = require './service/rpcService'

async.waterfall [
	(callback)->
		connectorServer.initServer 13000, callback
	(io, callback)->
		rpc.init ['http://127.0.0.1:13001'], io, callback
], (err)->
	return console.log "server start" unless err

	console.log util.inspect(err)
	process.exit 1