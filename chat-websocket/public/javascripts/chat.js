 $(function () {
    var content = $('#content');
    var status = $('#status');
    var input = $('#input');
    var myName = false;

    //建立websocket连接
    socket = io.connect('http://ping.3g.cn:8080');
    //收到server的连接确认
    socket.on('open',function(){
        status.text('input a name:');
    });

    //监听system事件，判断welcome或者disconnect，打印系统消息信息
    socket.on('system',function(json){
        var p = '';
        if (json.type === 'welcome'){
            if(myName==json.text) status.text(myName + ': ').css('color', json.color);
            p = '<p style="background:'+json.color+'">system  @ '+ json.time+ ' : Welcome ' + json.text +'</p>';
        }else if(json.type == 'disconnect'){
            p = '<p style="background:'+json.color+'">system  @ '+ json.time+ ' : Bye ' + json.text +'</p>';
        }
        content.prepend(p); 
    });

    
    socket.on('roomChat',function(json){
        console.log(json);
        var p = '<p> '+json+'</p>';
        content.prepend(p);
    });
 
    socket.on('privateChat',function(json){
        console.log(json);
        var p = '<p> '+json+'</p>';
        content.prepend(p);
    });

    //通过“回车”提交聊天信息
    input.keydown(function(e) {
        if (e.keyCode === 13) {
            var msg = $(this).val();
            $(this).val('');
            socket.emit('roomChat', msg);
        }
    });

    $('#commit').click(function(){
        var roomToken = "room"+ $('#inputRoomNum').val()||"1";
        var name = $('#inputName').val();
        msg = {
            userId: name,
            roomToken: roomToken
        }
        socket.emit("login", msg);
        $('#commit').hide();
        $('#send').show();
    })
});