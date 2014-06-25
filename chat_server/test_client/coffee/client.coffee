io = require 'socket.io-client'

socketClient = io.connect "http://127.0.0.1:13000"
socketClient.on 'connect', ()->

	socketClient.emit 'login', {userName: "test", password: "test_pwd"}, (ack)->
		console.log ack

	socketClient.on 'data', (data)->
		connector.broadcast

	socketClient.on 'disconnect', ()->
		console.log ""
