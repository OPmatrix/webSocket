(function() {
  var handler, rpcSer, sessionSer;

  sessionSer = require('./sessionService');

  rpcSer = require('../remoteCall/rpcService');

  handler = (function() {

    function handler(app) {
      this.app = app;
    }

    handler.prototype.onLogin = function(session, msg) {
      var conId, eid, password, userName;
      userName = msg.userName, password = msg.password, eid = msg.eid;
      return conId = this.app.id;
    };

    handler.prototype.onMsg = function(session, msg) {
      return rpcSer.send(session, data);
    };

    handler.prototype.onDisConnect = function(session, msg) {
      return sessionSer.leaveAndSync(session);
    };

    return handler;

  })();

}).call(this);
