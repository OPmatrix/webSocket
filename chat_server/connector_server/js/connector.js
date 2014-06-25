(function() {
  var Handler, io, sessionSer, _unauthorized;

  io = reuqire('socket.io')(10011);

  Handler = require('./handler/entryHandler');

  sessionSer = require('./sessionService');

  io.on("connection", function(socket) {
    var handler, session;
    socket.emit('open');
    handler = new Handler(io);
    session = sessionSer.newSession(socket.id);
    socket.on('login', function(data) {
      return handler.onLogin(session, data);
    });
    socket.on('msg', function(data) {
      if (!session.verify) return _unauthorized(socket);
      return handler.onMsg(session, data);
    });
    socket.on('room', function(data) {
      if (!session.verify) return _unauthorized(socket);
      return handler.onRoom(session, data);
    });
    return socket.on('disconnect', function(data) {
      return handle.onDisconnect(session, data);
    });
  });

  _unauthorized = function(socket) {
    return socket.emit("data", {
      code: 402
    });
  };

}).call(this);
