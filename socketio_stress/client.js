var util = require('util');

var io = require('socket.io-client');

var roomNum = parseInt(process.argv[2]);
var index = parseInt(process.argv[3]);
console.log("concurrent socket connections is " + index);

function newConnection(index){
    var send = 0;
    var recv = 0;

    //建立websocket连接
    var socket = io.connect('http://61.145.124.32:8282');

    socket.on('connect_error',function(err){
        console.log('connect err:' + util.inspect(err));
    });

    //收到server的连接确认
    socket.on('open',function(){
        console.log('input a name:');
    });
    

    //监听system事件，判断welcome或者disconnect，打印系统消息信息
    socket.on('system',function(json){
        console.log("system : " + json);
    });

    
    socket.on('roomChat',function(json){
        recv++;
        // console.log( index + "recv: " + recv + " send: " + send + ": roomChat : " + json) ;
    });
 
    socket.on('privateChat',function(json){
       console.log("privateChat : " + json);
    });

    var userInfo = {
        userId: "stress_" + index,
        roomToken: "room" + roomNum
    };
    socket.emit("login", userInfo);
    // setInterval(function (){
    //     send++;
    //     // console.log( index + "recv: " + recv + " send: " + send ) ; 
    //     socket.emit("roomChat", index + ": 我的家在东北松花江上");
    // }, 50000 + Math.random()*10000);
}

newConnection(index);
