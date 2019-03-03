<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <title>登录</title>
    <style>
        body{
            margin: 15vw 0 0 0;
            padding: 0;
        }
        body{
            background: url("img/2.JPG") no-repeat;
            background-size: 100%;.jpg',sizingMethod='scale');
        }

    </style>
</head>
<body>
    <div id="loginVue" class="container-fluid">
        <div class="col-lg-6 col-lg-offset-3">
            <form role="form" @submit.prevent="submit">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">
                            <span class="glyphicon glyphicon-user"></span>
                        </div>
                        <input type="text" class="form-control" required v-model="username"  placeholder="username">
                    </div>
                    <br />
                    <div class="input-group">
                        <div class="input-group-addon">
                            <span class="glyphicon glyphicon-lock"></span>
                        </div>
                        <input type="password" class="form-control" required v-model="password" placeholder="password">
                    </div>
                </div>
                <div class="form-group">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" v-model="rememberMe"> 记住密码
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-info btn-block" value="登录" />
                    <p style="color: red;">{{errormsg}}</p>
                </div>
            </form>
        </div>
    </div>
</body>
<script type="text/javascript" src="js/vue.min.js"></script>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script>
    var loginVue = new Vue({
        el:"#loginVue",
        data:{
            username:'',
            password:'',
            errormsg:'',
            rememberMe:false
        },
        methods:{
            submit:function(){
                //var username = $("#username").val().trim();
                //var password = $("#password").val().trim();
                if(loginVue.username==""||loginVue.password==""){
                    return ;
                }
                $.ajax({
                    type:"POST",
                    url:"/login",
                    data:{"username":loginVue.username,"password":loginVue.password,"rememberMe":loginVue.rememberMe},
                    success:function (msg) {
                        if(msg!="success"){
                            loginVue.errormsg = msg;
                        }else{
                            location.href="/main";
                        }
                    }
                });
            }
        }
    });
</script>
</html>