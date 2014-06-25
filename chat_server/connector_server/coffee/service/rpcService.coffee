async = require 'async'
io = require 'socket.io-client'
log = require('../utils/log').getLogger('rpc')
SERV_ID = 1;
businessServList = {}

module.exports = 
	init: (serverUrls, connector, callback)->
		async.forEach serverUrls, (serverUrl, cb)->
			return cb null if businessServList[serverUrl]
			
			socketClient = io.connect serverUrl
			socketClient.on 'connect', ()->

				console.log "connect to rpc server " + serverUrl
				socketClient.emit 'register', {id: SERV_ID}

				businessServList[serverUrl] = socketClient

				socketClient.on 'data', (trunk, next)->
					_recv connector, trunk, next

				socketClient.on 'disconnect', ()->
					console.log "disconnect"
					delete businessServList[serverUrl]
				cb null

			socketClient.on 'connect_error', (err)->
				console.log err
				cb err

			socketClient.on 'connect_timeout', (err)->
				console.log err
		, callback

	verifyUser: (data, cb)->
		trunk = 
			data: data
			route: verifyUser
		_LBserver().emit "data", trunk, cb

	send: (session, route, data, next)->
		trunk = 
			conId: session.socketId
			route: route
			data: data
		_LBserver().emit "data", trunk, next


	userLeave: (session, data, cb)->
		trunk = 
			data: data
			route: "userLeave"
			conId: session.conId
		_LBserver().emit ,""

_recv = (connector, trunk, next)->
	{route, data} = trunk
	connector.sockets.emit route, data, next


#@hash   conId -> server
_LBserver = ()->
	for serverUrl, socket of businessServList
		return socket
	