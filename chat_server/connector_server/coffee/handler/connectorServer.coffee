sessionSer = require '../service/sessionService'
rpcSer = require '../service/rpcService'
log = require('../utils/log').getLogger 'connectorServer'



module.exports =
	initServer: (port, cb)->
		io = require('socket.io').listen port

		io.sockets.on "connection", (socket)->

			socket.emit 'open' 

			socketId = socket.id
			session = sessionSer.newSession socketId

			socket.on 'login', (trunk, next)->
				log.debug 'login', arguments
				_onLogin session, trunk, next

			socket.on 'data', (trunk, next)->
				log.debug 'data', arguments
				{route, data} = trunk
				return _badRequest next unless route
				return _unauthorized next unless session.verify
				
				rpcSer.send session, route, data, next

			socket.on 'disconnect', (trunk)->
				log.debug 'disconnect', arguments
				rpcSer.userLeave session, trunk, next
				sessionSer.userLeave session

		console.log "init socket.io server@#{port}"
		cb null, io					

_onLogin = (session, msg, next)->
		{userName, password} = msg

		#@todo  verify
		rpcSer.verifyUser {userName, password}, (data)->
			next data


_unauthorized = (next)->
	next {code: 402} if next


_badRequest = (next)->
	next {code: 400} if next