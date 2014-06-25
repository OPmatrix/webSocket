SER_ID = 0;
SESSION = {}

###
	sesssion:
		uid: {
			equipment: {
				conId:
				userInfo: {
	
				}
			}
		}
###



module.exports = 
	newSession: (socketId)->
		if !SESSION[socketId]
			SESSION[socketId] = 
				socketId: socketId
				verify: true
		return SESSION[socketId]

	verify: (session)->
		return unless SESSION[session.socketId] #log error
		SESSION[session.socketId].verify = true;

	userLeave: (session)->
		delete SESSION[session.socketId]





