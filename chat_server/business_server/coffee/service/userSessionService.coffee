
USER_SESSION = {}
ROOMS = {}

module.exports = 
	connect: (uid, servId)->
		unless USER_SESSION[uid]
			USER_SESSION[uid] = {servId, uid}
		return USER_SESSION[uid]

	get: (uid)->
		return USER_SESSION[uid]
				
	bind: (uid, userInfo)->
		{username, password} = userInfo
		USER_SESSION[uid].username = username
		USER_SESSION[uid].password = password

	joinRoom: (uid, roomToken, cb)->
		return cb "#{uid} not exits" unless USER_SESSION[uid] 
		USER_SESSION[uid].roomToken = roomToken

		ROOMS[roomToken] = [] unless ROOMS[roomToken]
		ROOMS[roomToken].push uid
		return cb null

	level: (uid, cb)->

	register: (session, servId)->
		return unless USER_SESSION[session.socketId] #log error
		
		USER_SESSION[session.socketId].servId = servId;

	disconnect: (session)->
		delete USER_SESSION[session.socketId]