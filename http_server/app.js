var net = require('net');
var server = net.createServer(function(c) { //'connection' listener
  console.log('server connected');
  c.on('end', function() {
    console.log('server disconnected');
  });
  c.on('data', function(incomingData) {
  	console.log(incomingData.toString());
 	c.write('HTTP/1.1 200 OK\nContent-Type: text/xml;charset=utf-8\nContent-Length: 5\n\nhello\r\n');
  })
});
server.listen(8124, function() { //'listening' listener
  console.log('server bound@8124');
});
