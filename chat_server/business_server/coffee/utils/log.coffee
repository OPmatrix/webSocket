

module.exports =
	getLogger: (name='master')->
		logger = 
			error: ()->
				console.log arguments
			warn: ()->
				console.log arguments
			debug: ()->
				console.log arguments

		return logger
