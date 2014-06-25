io = require('socket.io').listen 13001
handler = require './handler/businessHandler'
serverSessionSer = require './service/serverSessionSerice'
userSesssionSer = require '../service/userSessionService'
log = require('./utils/log').getLogger('business_server')


io.sockets.on "connection", (socket)->
	socket.emit 'open' 

	servSession = serverSessionSer.connect socket.id, socket

	socket.on 'register', (data, next)->
		handler.registerServer session, data, next

	socket.on 'data', (trunk, next)->
		log.debug 'data', arguments
		{route, uid, data} = trunk
		servId = socket.id

		return next {code: 400, msg: ""} unless route
		return next {code: 404, msg: ""} unless handler[route]
		userSesssionSer.connect uid, servId

		handler[route] servId, uid, data, next

	socket.on 'disconnect', ()->
		serverSessionSer.disconnect session


	# socket.on 'login', (data)->
	# 	handler.onLogin session, data

	# socket.on 'session', (data)->
	# 	{session, data} = trunk
	# 	handler.onSession session, data

	# socket.on 'server', (trunk)->
	# 	{session, data} = trunk
	# 	handler.onServer session, data

	# socket.on 'data', (data)->
	# 	{session, data} = trunk
	# 	handle.onData session, data

_unauthorized = (socket)->
	socket.emit "data", {code:402}
