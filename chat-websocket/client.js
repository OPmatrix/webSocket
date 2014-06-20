
var util = require('util');
var clientMap = [];

function Client(io, socket){
	this.io = io;

	this.socket = socket;
	this.chatId = socket.id;
	this.userId = "";
	this.roomToken = "";

}

Client.prototype.login = function (msg) {
	console.log("login:" + util.inspect(msg));

	this.userId = msg.userId;
	this.roomToken = msg.roomToken;

	console.log(this.roomToken + " " + this.chatId);
	this.socket.join(this.roomToken);
	saveClient_(this.chatId, this.userId);

	var content = this.userId + "Login"
	//返回欢迎语
	this.socket.emit(this.roomToken, content);
	//广播新用户已登陆
	this.socket.broadcast.emit(this.roomToken, content);

}

Client.prototype.privateChat = function(msg) {
	var toChatID = clientMap[msg.to];
	console.log(clientMap);
	var content = this.userId + " say to your: "+ msg.content;

	console.log("privateChat " + util.inspect(msg) + "  "+ toChatID) ;
	this.io.sockets.sockets[toChatID].emit('privateChat', content);
}


Client.prototype.roomChat = function(msg) {
	var content = this.userId + " say: "+ msg;
	console.log("roomChat " + content);

	// 返回消息（可以省略）
	this.socket.emit(this.roomToken, content);
	// 广播向其他用户发消息
	this.io.sockets.in(this.roomToken).emit('roomChat', content);
}

Client.prototype.disConnect = function() {
	console.log("disConnect");

	var content = this.userId + " disConnect";
	delete(clientMap[this.userId]);
	if(this.socket!=null){
		this.io.sockets.in(this.roomToken).emit('system', content);
	}
}

var saveClient_ = function(chatId, userId) {
	clientMap[userId] = chatId;
}

module.exports = Client;