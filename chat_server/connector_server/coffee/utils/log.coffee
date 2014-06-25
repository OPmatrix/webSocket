

module.exports =
	getLogger: (name='master')->
		logger = 
			error: ()->
				console.log name, arguments
			warn: ()->
				console.log name, arguments
			debug: ()->
				console.log name, arguments
			console: ()->
				console.log name, arguments

		return logger
