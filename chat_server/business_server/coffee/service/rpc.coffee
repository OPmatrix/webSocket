
io = null

EmptyCallback = ()->

module.exports = 
	init: (io)->
		io = null

	broadCastRoom : (data, next)->
		next = EmptyCallback unless next
		trunk =
			route: 'roomChat'
			data: data
		io.sockets.emit "data", trunk, next 


