SER_ID = 0;
SERVER_SESSION = {}

module.exports = 
	connect: (servId, socket)->
		if !SERVER_SESSION[servId]
			SERVER_SESSION[servId] = {servId}

		return SERVER_SESSION[servId]

	register: (servId)->
		return unless SERVER_SESSION[servId] #log error
		
		SERVER_SESSION[servId] = {servId};

	disconnect: (session)->
		delete SERVER_SESSION[session.servId]