<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <#--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
    <#--<meta name="viewport" content="width=device-width, initial-scale=1">-->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css">
    <title>记账</title>
</head>
<body>
    <nav class="nav navbar-inverse">
        <div class="navbar-header">
            <!--在移动端的时候导航条折叠起来，三横的样式出现，点击该样式可以显示或隐藏导航条上的内容-->
            <button class="navbar-toggle" data-toggle="collapse" data-target="#menu">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="javascript:void(0)" class="navbar-brand">胡露账本</a>
        </div>
        <div id="menu" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#" >原始数据录入</a></li>
                <li><a href="#">数据报表</a></li>
                <!--下拉菜单功能的实现-->
                <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    报表图<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">柱状图</a></li>
                        <li><a href="#">饼状图</a></li>
                    </ul>
                </li>
                <li ><a href="/loginout" >退出</a></li>
            </ul>
        </div>
    </nav>

    <div class="panel panel-default">
        <div class="panel-heading" style="background-color: #5bc0de">
            位置： 账本 > 原始数据录入 > 营业额/支付录入
        </div>
    </div>


    <div id="szvue">
        <div class="form-inline">
            <div class="input-group col-lg-2">
                <div class="input-group-addon">时间</div>
                <input type="text"  readonly v-model="sztime1" id="sztime1"  class="form-control form_datetime" />
            </div>
            <button class="btn btn-info" @click="findDetails">查询</button>
            <button class="btn btn-danger" data-toggle="modal" data-target="#addDetail">记明细</button>
            <button class="btn btn-success" @click="saveDetail">保存</button>

            <!-- addDetail 模态框 -->
            <div class="modal fade" id="addDetail" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h3 class="modal-title" >营业额/收支录入</h3>
                        </div>

                            <div class="modal-body">
                                <div class="input-group">
                                    <div class="input-group-addon">时间</div>
                                    <input type="text" required  readonly v-model="sztime2" id="sztime2"  class="form-control form_datetime" />
                                </div>
                                <hr/>
                                <div class="input-group">
                                    <div class="input-group-addon">店铺名称</div>
                                    <select class="form-control" required v-model="shopid">
                                        <option v-for="t in shopnames" v-bind:value="t.shopid">{{t.shopname}}</option>
                                    </select>
                                </div>
                                <hr/>
                                <div class="input-group">
                                    <div class="input-group-addon">收入/支出</div>
                                    <select class="form-control" v-model="typeno" required v-on:change="typeChange">
                                        <option v-for="f in types" v-bind:value="f.typeno">{{f.typename}}</option>
                                    </select>
                                </div>
                                <div class="input-group">
                                    <div class="input-group-addon">类型</div>
                                    <select class="form-control" v-model="typeid" required>
                                        <option v-for="fd in type_del" v-bind:value="fd.typeid">{{fd.typename}}</option>
                                    </select>
                                </div>
                                <hr/>

                                <div class="input-group">
                                    <div class="input-group-addon">金额</div>
                                    <input type="text" v-model="money" class="form-control" required>
                                </div>
                                <hr/>
                                <div class="input-group">
                                    <span class="input-group-addon">备注：</span>
                                    <textarea class="form-control" v-model="remark"  cols="60"></textarea>
                                </div>


                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button class="btn btn-default" @click="addDetail">添加</button>
                            </div>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <!-- 表格的面板 -->
        <div class="panel panel-default">
            <div class="panel-heading">
                记账明细
            </div>

            <!--表格-->
            <table class="table table-hover">
                <thead>
                <tr>
                    <td>日期</td>
                    <td>店铺名称</td>
                    <td>金额</td>
                    <td>收入/支出</td>
                    <td>类型</td>
                    <td>备注</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <tr v-for="(value,index) in alldetails">
                    <td>{{value.ctime}}</td>
                    <td>{{value.shopname}}</td>
                    <td>{{value.money}}</td>
                    <td>{{value.tname}}</td>
                    <td>{{value.typename}}</td>
                    <td>{{value.remark}}</td>
                    <td>
                        <button class="btn btn-default btn-xs" @click="delDetail(index,value.id)">删除</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" style="background-color: #5bc0de">
            位置： 账本 > 原始数据录入 > 消费数量/类型录入
        </div>
    </div>


    <div id="cutvue">
        <div class="form-inline">
            <div class="input-group col-lg-2">
                <div class="input-group-addon">时间</div>
                <input type="text"  readonly v-model="cuttime1" id="cuttime1"  class="form-control form_datetime" />
            </div>
            <button class="btn btn-info" @click="findCos">查询</button>
            <button class="btn btn-danger" data-toggle="modal" data-target="#addDetai2">记总账</button>
            <button class="btn btn-success" @click="saveCos">保存</button>

            <!-- addDetail 模态框 -->
            <div class="modal fade" id="addDetai2" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h3 class="modal-title" >消费数量/类型录入</h3>
                        </div>

                        <div class="modal-body">
                            <div class="input-group">
                                <div class="input-group-addon">时间</div>
                                <input type="text" required  readonly v-model="cuttime2" id="cuttime2"  class="form-control form_datetime" />
                            </div>
                            <hr/>
                            <div class="input-group">
                                <div class="input-group-addon">店铺名称</div>
                                <select class="form-control" required v-model="shopid">
                                    <option v-for="t in shopnames" v-bind:value="t.shopid">{{t.shopname}}</option>
                                </select>
                            </div>
                            <hr/>
                            <div class="input-group">
                                <div class="input-group-addon">顾客类型</div>
                                <select class="form-control" v-model="csid" required >
                                    <option v-for="f in costypes" v-bind:value="f.csid">{{f.costypename}}</option>
                                </select>
                            </div>

                            <div class="input-group">
                                <div class="input-group-addon">上午/下午</div>
                                <select class="form-control" required v-model="sid">
                                    <option v-for="t in sts" v-bind:value="t.sid">{{t.stime}}</option>
                                </select>
                            </div>
                            <hr/>

                            <div class="input-group">
                                <div class="input-group-addon">人数</div>
                                <input type="text" v-model="num" class="form-control" required>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">金额</div>
                                <input type="text" v-model="sum" class="form-control" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button class="btn btn-default" @click="addCos">添加</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <!-- 表格的面板 -->
        <div class="panel panel-default">
            <div class="panel-heading">
                记账明细
            </div>

            <!--表格-->
            <table class="table table-hover">
                <thead>
                <tr>
                    <td>日期</td>
                    <td>店铺名称</td>
                    <td>顾客类型</td>
                    <td>上午/下午</td>
                    <td>数量</td>
                    <td>金额</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <tr v-for="(value,index) in allCoss">
                    <td>{{value.ctime}}</td>
                    <td>{{value.shopname}}</td>
                    <td>{{value.costypename}}</td>
                    <td v-if="value.stime==1">上午</td><td v-else>下午</td>
                    <td>{{value.num}}</td>
                    <td>{{value.sum}}</td>
                    <td>
                        <button class="btn btn-default btn-xs" @click="delCos(index,value.id)">删除</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>


</body>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="js/vue.min.js"></script>
<script type="text/javascript" src="js/json2.js"></script>
<script type="text/javascript" src="js/main.js"></script>
</html>