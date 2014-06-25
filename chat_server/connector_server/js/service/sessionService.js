(function() {
  var SER_ID, SESSION, SESSION_MAP;

  SER_ID = 0;

  SESSION = {};

  SESSION_MAP = {};

  /*
  	sesssion:
  		uid: {
  			equipment: {
  				conId:
  				userInfo: {
  	
  				}
  			}
  		}
  */

  module.exports = {
    newSession: function(socketId) {
      if (!SESSION[socketId]) {
        SESSION[socketId] = {
          socketId: socketId,
          verify: false
        };
      }
      return SESSION[socketId];
    },
    verify: function(session) {
      if (!SESSION[session.socketId]) return;
      return SESSION[session.socketId].verify = true;
    },
    leaveAndSync: function(session) {}
  };

}).call(this);
