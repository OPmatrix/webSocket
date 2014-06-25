serverSessionSer = require '../service/serverSessionService'
userSesssionSer = require '../service/userSessionService'
rpc = require '../service/rpc'
log = require('../utils/log').getLogger('businessHandler')

module.exports =
	registerServer: (servId, data, next)->
		serverSession.register servId
		next {code: 200} if next

	verifyUser: (servId, uid, data, next)->
		log.debug 'onVerifyUser', data
		#@todo verify user
		userSesssionSer.bind uid, data
		next {code: 200} if next

	roomChat: (servId, uid, data, next)->
		log.debug 'roomChat', data
		roomToken  = userSesssionSer.get(uid).roomToken
		#todo  ??
		unless roomToken
			

		target = 

		rpc. target, data
		next {code: 200} if next

	room: (servId, uid, data, next)->
		log.debug 'room', data
		{roomToken} = data
		userSesssionSer.joinRoom uid, roomToken, next
