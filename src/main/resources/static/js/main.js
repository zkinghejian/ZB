/**
 * Created by USER on 2019/1/23.
 */

var szvue = new Vue({
    el:"#szvue",
    data:{
        cstatus:'1',// 默认为查询查询状态  1 查询  2 记一笔
        sztime1:new Date().getFullYear()+"-"+(new Date().getMonth()+1)+"-"+new Date().getDate(),
        sztime2:new Date().getFullYear()+"-"+(new Date().getMonth()+1)+"-"+new Date().getDate(),
        types:'',  // 收支
        typeno:1,
        type_del:'',
        typeid:6 , // 支付宝  油米
        shopnames:'',
        shopid:2,// 商铺id  默认为第二个店
        remark:'',
        money:'0.00',
        alldetails:[],
    },
    methods: {
        dateDefind:function() {
            $("#sztime1").datetimepicker({
                format:'yyyy-mm-dd',
                language:'zh-CN',// 中文
                startView:2, // 2 点开时间选择器 第一个视图  日期
                minView:2, // 最精确的视图
                autoclose:1 // 选择后自动关闭
                // 当选择了开始日期 设置为endtime 的开始时间
            }).on("changeDate",function(){
                szvue.sztime1 = $("#sztime1").val();
            });
            $("#sztime2").datetimepicker({
                format:'yyyy-mm-dd',
                language:'zh-CN',// 中文
                startView:2, // 2 点开时间选择器 第一个视图  日期
                minView:2, // 最精确的视图
                autoclose:1 // 选择后自动关闭
                // 当选择了开始日期 设置为endtime 的开始时间
            }).on("changeDate",function(){
                szvue.sztime2 = $("#sztime2").val();
            });
        },
        // 获取店铺
        getShop:function () {
            $.ajax({
                type:"get",
                url:"/getshopnames",
                success:function (names) {
                    szvue.shopnames=names;
                }
            });
        },
        //获取类型
        getTypes:function () {
            $.ajax({
                type:"get",
                url:"/gettypes",
                success:function (ts) {
                    //alert(ts.typesname);
                    szvue.types=ts;
                    szvue.type_del=szvue.types[0].types;
                    szvue.typeid=1;
                }
            });
        },
        typeChange:function () {
            if(szvue.typeno==1){
                szvue.type_del = szvue.types[0].types;
                szvue.typeid = 1;
            }else{
                szvue.type_del = szvue.types[1].types;
                szvue.typeid = 6;
            }
        },
        addDetail:function () {
            var that = szvue;
            if(that.cstatus=='1'){
                that.alldetails=[];
                that.cstatus='2'; // 记一笔 状态
            }
            // 创建一个detail 对象
            var detail = {"shopid":that.shopid,"shopname":that.shopnames[that.shopid-1].shopname,"typeid":that.typeid,"money":that.money,"ctime":that.sztime2,"remark":that.remark,"typeno":that.typeno,"tname":that.findType(that.typeno,''),"typename":that.findType(that.typeno,that.typeid),"id":''};
            that.alldetails.push(detail);
            $("#addDetail").modal('hide');
            // 清理数据
            that.ztime2=new Date().getFullYear()+"-"+(new Date().getMonth()+1)+"-"+new Date().getDate();
            if(that.typeno==1){
                that.typeid=1 ;
            }else{
                that.typeid=6 ; // 支付宝  油米
            }
            that.shopid=2;// 商铺id  默认为第二个店
            that.remark='';
            that.money='0.00';
        },
        // 根据编号选择类型
        findType:function (typeno,typeid) {
            var that = szvue;
            var ts = that.types;
            if(typeno!=''&&typeid==''){
                for(var i=0;i<ts.length;i++){
                    if(typeno==ts[i].typeno){
                        return ts[i].typename;
                    }
                }
            }
            if(typeno!=''&&typeid!=''){
                for(var i=0;i<ts.length;i++){
                    if(typeno==ts[i].typeno){
                        var tss = ts[i].types;
                        for(var j=0;j<tss.length;j++){
                            if(typeid==tss[j].typeid){
                                return tss[j].typename;
                            }
                        }
                    }
                }
            }
        },
        delDetail:function(id1,id2){
            var that = szvue;
            // id1 是记一笔
            // id2 数据库id
            if(that.cstatus=='2'){
                that.alldetails.splice(id1,1);
                if(that.alldetails.length==0){
                    that.cstatus=='1';
                }
            }else{
                // 从数据删除数据
                if(confirm("确定从数据库删除数据？")){
                    $.ajax({
                        type:"post",
                        url:"/delDetail/"+id2,
                        //data:{"id":id2},
                        success:function(s){
                            if(s=="success"){
                                that.findDetails();
                            }
                        }
                    });
                }else{
                    return;
                }
            }
        },
        saveDetail:function(){
            var that = szvue;
            if(that.cstatus=='2'){
                $.ajax({
                    type:"post",
                    url:"/addDetails",
                    // dataType:'json', 告诉服务器要传回 xml 或json
                    data:{"details":JSON.stringify(that.alldetails)},
                    success:function (s) {
                       if(s=="success"){
                           // 清空
                           that.alldetails = [];
                           // 状态改为查询
                           that.cstatus = '1';
                       }
                    }
                });
            }else{
                alert("请先记账，再保存!!!");
            }
        },
        // 查询改日期的记账情况
        findDetails:function () {
            var that = szvue;
            if(that.cstatus=='1'){
                //清空
                that.alldetails=[];
                $.ajax({
                    type:"post",
                    url:"/findDetails",
                    data:{"date":that.sztime1},
                    success:function (date) {
                        that.alldetails = date;
                        that.cstatus=='1';
                    }
                });
            }else{
                alert("请先保存数据！！")
            }
        }
    },
    mounted: function () {
        this.dateDefind();
        this.getShop();
        this.getTypes();
    }
});

var cutvue = new Vue({
    el:"#cutvue",
    data:{
        cstatus:'1',
        cuttime1:new Date().getFullYear()+"-"+(new Date().getMonth()+1)+"-"+new Date().getDate(),
        cuttime2:new Date().getFullYear()+"-"+(new Date().getMonth()+1)+"-"+new Date().getDate(),
        shopid:'1',
        shopnames:'',
        costypes:'',
        csid:'1',
        sts:[{"sid":1,"stime":"上午"},{"sid":2,"stime":"下午"}],
        sid:'1',
        num:'',
        allCoss:[],
        sum:'',
    },
    methods:{
        dateDefind:function() {
            $("#cuttime1").datetimepicker({
                format:'yyyy-mm-dd',
                language:'zh-CN',// 中文
                startView:2, // 2 点开时间选择器 第一个视图  日期
                minView:2, // 最精确的视图
                autoclose:1 // 选择后自动关闭
                // 当选择了开始日期 设置为endtime 的开始时间
            }).on("changeDate",function(){
                cutvue.cuttime1 = $("#cuttime1").val();
            });
            $("#cuttime2").datetimepicker({
                format:'yyyy-mm-dd',
                language:'zh-CN',// 中文
                startView:2, // 2 点开时间选择器 第一个视图  日期
                minView:2, // 最精确的视图
                autoclose:1 // 选择后自动关闭
                // 当选择了开始日期 设置为endtime 的开始时间
            }).on("changeDate",function(){
                cutvue.cuttime2 = $("#cuttime2").val();
            });
        },
        getShop:function () {
            $.ajax({
                type:"get",
                url:"/getshopnames",
                success:function (names) {
                    cutvue.shopnames=names;
                }
            });
        },
        findCos:function () {
            var that = cutvue;
            if(that.cstatus=='1'){
                //清空
                that.allCoss=[];
                $.ajax({
                    type:"post",
                    url:"/findCoss",
                    data:{"date":that.cuttime1},
                    success:function (date) {
                        that.allCoss = date;
                        that.cstatus=='1';
                    }
                });
            }else{
                alert("请先保存数据！！")
            }
        },
        saveCos:function () {
            var that = cutvue;
            if(that.cstatus=='2'){
                $.ajax({
                    type:"post",
                    url:"/addCoss",
                    // dataType:'json', 告诉服务器要传回 xml 或json
                    data:{"coss":JSON.stringify(that.allCoss)},
                    success:function (s) {
                        if(s=="success"){
                            // 清空
                            that.allCoss = [];
                            // 状态改为查询
                            that.cstatus = '1';
                        }
                    }
                });
            }else{
                alert("请先添加原始数据，再保存!!!");
            }
        },
        getCosTypes:function () {
            $.ajax({
               type:"get",
               url:"/getCosTypes",
               success:function (types) {
                   cutvue.costypes = types;
               }
            });
        },
        addCos:function () {
            var that = cutvue;
            if(that.cstatus=='1'){
                that.allCoss=[];
                that.cstatus='2'; // 记一笔 状态
            }
            // 创建一个detail 对象
            var cos = {"sum":that.sum,"shopid":that.shopid,"shopname":that.shopnames[that.shopid-1].shopname,"csid":that.csid,"costypename":that.costypes[that.csid-1].costypename,"ctime":that.cuttime2,"stime":that.sid,"num":that.num};
            that.allCoss.push(cos);
            $("#addDetai2").modal('hide');
            // 清理数据
            that.cuttime2=new Date().getFullYear()+"-"+(new Date().getMonth()+1)+"-"+new Date().getDate();
            that.shopid=1;// 商铺id  默认为第一个店
            that.num='';
            that.sum ='';
        },
        delCos:function (id1,id2) {
            var that = cutvue;
            // id1 是记一笔
            // id2 数据库id
            if(that.cstatus=='2'){
                that.allCoss.splice(id1,1);
                if(that.allCoss.length==0){
                    that.cstatus = '1';
                }
            }else{
                // 从数据删除数据
                if(confirm("确定从数据库删除数据？")){
                    $.ajax({
                        type:"post",
                        url:"/delCos/"+id2,
                        //data:{"id":id2},
                        success:function(s){
                            if(s=="success"){
                                that.findCos();
                            }
                        }
                    });
                }else{
                    return;
                }
            }
        }
    },
    mounted: function () {
        this.dateDefind();
        this.getShop();
        this.getCosTypes();
    }
});
