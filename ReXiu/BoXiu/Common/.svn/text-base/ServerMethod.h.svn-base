//
//  ServerMethod.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-13.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#ifndef MemberMarket_ServerMethod_h
#define MemberMarket_ServerMethod_h


/*如果支持des加密则打开*/
#define Des_Encode

#define Request_Suffix                  @"mobile/dispatch.mobile"//普通post请求后缀

#define ServerBaseUrl                   @"http://www.51rebo.cn" //正式服务器
#define Model_ServerBaseUrl             @"http://www.model.51rebo.cn"/*模侧环境*/
#define Test_ServerBaseUrl              @"http://www.test.51rexiu.com"/*测试环境*/
#define QXQ_ServerBaseUrl               @"http://192.168.1.189:9292"//许飞服务器
#define TYW_ServerBaseUrl               @"http://test.154.51rexiu.cn:9292"//谭耀武服务器
#define ZhouFeng_ServerBaseUrl          @"http://192.168.1.32:9292"/*文磊服务器*/
#define Test1_ServerBaseUrl              @"http://www.test1.51rexiu.com"/*性能服务器器*/

#define Request_ServerBaseUrl           [NSString stringWithFormat:@"%@/%@",ServerBaseUrl,Request_Suffix];
#define Model_Request_ServerBaseUrl     [NSString stringWithFormat:@"%@/%@",Model_ServerBaseUrl,Request_Suffix];
#define Test_Request_ServerBaseUrl      [NSString stringWithFormat:@"%@/%@",Test_ServerBaseUrl,Request_Suffix];
#define Test1_Request_ServerBaseUrl      [NSString stringWithFormat:@"%@/%@",Test1_ServerBaseUrl,Request_Suffix];
#define QXQ_Request_ServerBaseUrl       [NSString stringWithFormat:@"%@/%@",QXQ_ServerBaseUrl,Request_Suffix];
#define TYW_Request_ServerBaseUrl       [NSString stringWithFormat:@"%@/%@",TYW_ServerBaseUrl,Request_Suffix];
#define ZhouFeng_Request_ServerBaseUrl  [NSString stringWithFormat:@"%@/%@",ZhouFeng_ServerBaseUrl,Request_Suffix];

#define SystemId                        @"talent-base-app"

#define ResourceBaseUrl                 @"http://res01.51rebo.cn"
#define Model_ResourceBaseUrl           @"http://res01.model.51rebo.cn"
#define Test_ResourceBaseUrl            @"http://122.225.67.71"
#define QXQ_ResourceBaseUrl             Test_ResourceBaseUrl
#define TYW_ResourceBaseUrl             Test_ResourceBaseUrl
#define ZhouFeng_ResourceBaseUrl        Test_ResourceBaseUrl

#define TCP_SERVER_PORT                 @"9321"

#define PROTOCOL_URL                    @"http://res01.51rebo.cn/mobile-res/protocol.html"
#define Model_PROTOCOL_URL              PROTOCOL_URL
#define Test_PROTOCOL_URL               PROTOCOL_URL
#define QXQ_PROTOCOL_URL                Test_PROTOCOL_URL
#define TYW_PROTOCOL_URL                Test_PROTOCOL_URL
#define ZhouFeng_PROTOCOL_URL           Test_PROTOCOL_URL


/*定义网络接口*/
/*获取配置信息*/
#define GetConfig_Method            @"common/getConfig"
/*用户注册接口*/
#define Regsiter_Method             @"admin/user/add4mobile"
/*修改性别，昵称，城市*/
#define UpdataPersonInfo_Method     @"admin/user/updateCurrUserBySelective"
/*登录接口*/
#define Login_Method                @"admin/user/checkUsernameAndPwd4Mobile"
/*获取大厅数据*/
#define GetHallData_Method          @"main/gain"
/*查询主播列表*/
#define GetStarData_Method          @"chat/star/queryStarForMobile"

//邀请奖励
#define Rewards_Method              @"invite/rewards"

//查询推荐主播列表
#define Get_RecommendStarList_Method @"chat/star/recommendListStarQuery"

/*获取礼物列表*/
#define GetGift_Method              @"chat/gift/query"

/*个人信息获取*/
#define GetUserInfo_Method          @"admin/user/selectDetailInfo"

/*个人信息获取*/ //不传参数，用token
#define GetUserInfo_Method_UseToken          @"admin/user/selectCurrUserDetailInfo"
/*修改个人信息*/
#define updateCurrUser_Method       @"admin/user/updateCurrUserBySelective"
/*我的关注*/
#define GetAttention_Method          @"chat/userattention/getAttention"
/*推荐关注*/
#define ChangeAttention_Method       @"chat/userattention/changeAttention"
/*关注主播*/
#define AddAttention_Method          @"chat/userattention/add"
/*取消关注*/
#define DelAttention_Method          @"chat/userattention/del"
/*关注一批主播*/
#define addManyAttention_Method      @"chat/userattention/addMany"
/*获取房间信息*/
#define GetRoomInfo_Method           @"chat/getRoomInfo"
/*排行榜*/
#define getRank_Method               @"stat/ranklist/get"
/*粉丝榜*/
#define getFansRank_Method           @"chat/initRanking"
/*超级粉丝排行榜*/
#define getFansRankMonth_Method      @"chat/getFansRankMonth"
/*礼物排行榜(抢星)*/
#define GiftList_Method              @"stat/ranklist/giftlist"

/*修改密码*/
#define ModifyPassword_Method       @"admin/user/updatePwd"

/*提交反馈*/
#define Feedback_Method             @"feedback/save"

/*检查更新*/
#define CheckUp_Method              @"base/clientapp/queryNewestVersion/2"

#define Get_ChatMember_Method       @"chat/getMembers"

/*搜索*/
#define SearchUser_Method           @"admin/user/searchUser"
/*我看过的*/
#define SeenHistory_Method          @"user/seenlog/pagelist"
/*初始化沙发列表*/
#define SofaList_Method             @"chat/sofa/selectByShowId"

/*禁言*/
#define TakeUnSpeak_Method          @"chat/roomusermanage/unSpeakUserAjax"
/*踢人*/
#define Takeout_Method              @"chat/roomusermanage/takeOutUserAjax"

/*判断是否是第一次充值*/
#define First_Recharge_Method       @"usercenter/buycoin/hasBuyCoinData"

/*活动列表*/
#define ActivityQuery_Method        @"chat/activity/pageQuery"

/*周星榜(抢星)*/
#define StarGiftRank_Method         @"stat/ranklist/weekstarlist"

//支付宝才充值接口
#define AliPay_Recharge_Method      @"alipay4mobile/buy"


//美女热推数据
#define Get_HotStars_Method         @"chat/star/queryHotStarsForMobile"
//获取主播分类区块
#define Get_StarCategory_Method     @"chat/star/queryCategoryStarsForMobile"

//获取分区主播列表
#define Get_CategoryStarList_Method    @"chat/star/queryStarListAjax"

//获取大分区主播列表
#define Get_OneLevelCategoryStarList_Method @"chat/star/queryStarListByPid"

//获取广告位接口
#define Get_Poster_Method           @"main/queryMobilePoster"

//获取座驾
#define Get_UserCar_Method          @"chat/userprops/getUserPropsCar"

//获取房间照片
#define Get_RoomImages_Method       @"chat/room/getRoomShowImgs"

//绑定手机
#define Bind_Mobile_Method          @"usercenter/security/savephone"

//绑定获取验证码
#define Get_BindVerifyCode_Methode      @"sms/sendValidateCode"

//重置密码获取验证码
#define Get_ResetVerifyCode_Method   @"sms/sendResetPwdSmsCode"

//重设新密码
#define Reset_Password_Method       @"usercenter/security/resetPassword"

//获取用户赞
#define Get_PraiseNum_Method        @"chat/praise/getPraiseNumAjax"

//获取主播赞
#define Get_StarPraiseNum_Method    @"chat/praise/getStarPraiseNumAjax.talent"

//获取一级分区类别
#define Get_OneLevelCategory_Method         @"chat/starcategorylist/firstLevel"

//获取一级分区
#define Get_CagegoryStarList_Method  @"chat/star/queryStarListByPid"

//第三方登录接口第一步
#define BThird_Login_Method          @"login/bThirdLogin4mobile"
//第三方登录接口第二步
#define Third_Login_Method          @"login/thirdLogin4mobile"

//获取银联订单号
#define Get_UPPayOrderID_Method     @"yinglian4mobile/rechargeSubmit"

//正在直播
#define Query_OnLineStar_Method     @"chat/star/queryOnLineStarAjax"

//获取左侧二级菜单列表
#define Get_TwoLevelCategory_Method   @"chat/starcategorylist/secondLevel"
//座驾列表
#define CarGoodsQuery_Method        @"usercenter/buyprops/carGoodsQuery"
//座驾购买
#define BuyCar_Method               @"usercenter/buyprops/buyCar"

//购买VIP
#define BuyVIP_Method               @"shopping/buyVipFromMobile"

//获取是否隐藏充值 商城菜单
#define Is_HideRecharge_Method      @"common/hiddenPay"

//靓号查询
#define LiangQuery_Method           @"usercenter/idxcode/idxcodeQuery"
//
#define BuyIdxcode_Method           @"usercenter/idxcode/buyIdxcode"

//登录之前展示海报接口
#define queryMobileLoginPoster      @"chat/homepageposter/queryMobileLoginPoster"

//热豆兑换热币
#define beanTocoin_Method           @"usercenter/beantocoin/addBeanToCoin"

//推荐直播间获取推荐人员
#define QueryHotStars_Method        @"chat/star/queryHotStarsForMobile"

//手机端获取直播排期表
#define QueryLiveSchedules_Method   @"chat/liveschedule/queryLiveSchedulesForMobile2"

//appStore充值接口与服务器交互
#define Verify_Recharge_Appstore    @"applepay/verify"

//客户端打开签到
#define OpenClient_Method           @"base/clientapp/openClient"

//举报用户或主播
#define Report_Method               @"useraccusation/add"

//表情圈梁数据获取
#define Query_AllEmotion_Method       @"chat/emotion/queryAll"

//自动注册
#define AutoRegist_Method           @"admin/user/autoAdd4Mobile"

//自动注册退出修改密码
#define SetAutoRegistPwd_Method     @"admin/user/setPwd"

//直播间礼物排行榜
#define Query_StarGiftRank_Method   @"chat/statbigstargift/giftrank"

//免费点歌卷查询
#define HaveFreeTicket_Method       @"roommusic/haveFreeTicket"

//查询置顶节目
#define SelectTopLiveSchedule_Method @"chat/liveschedule/selectTopLiveschedule"

//热播间歌单列表
#define QueryRoommusicList_Method    @"roommusic/queryRoommusicList"

//点歌
#define ChoseMusic_Method            @"roommusic/choseMusic"

//首页广告
#define HomePagePoster_Method        @"chat/homepageposter/queryMobileIndexPoster"

//查询明星直播间礼物
#define Query_StarRoomGift_Method    @"chat/roomgift/queryRoomgift"

//获取服务器当前时间
#define Get_SystemTime_Method       @"system/getSystemTime"

//微信支付
#define WeixinPay_Method            @"weixinpay4mobile/buy"

//微信手机订单查询
#define WXOrderquer_Method            @"weixinpay4mobile/orderquery"

//启动页广告
#define Get_StartupPage_Method      @"chat/homepageposter/queryMobileStartingPoster"

//获取ShowTime当前状态
#define Get_ShowTimeState_Method    @"chat/showtime/getStatus"

//手机卡充值
#define Pay19PhoneRecharge_Method   @"pay19/rechargeSubmit"

//实名认证
#define IdentityVerify_Method       @"base/userauth/add.talent"

//上传头像接口
#define Upload_Photo_Method         @"admin/user/updUserPhoto.talent"

//获取某个字段
#define GetInfoUser_Method          @"admin/user/getOneField"

//是否可以手机直播
#define CanShowOnMobile_Method      @"chat/roomshow/canShow4Mobile"

//是否显示我要直播按钮
#define ShowLiveBtnOnMobile_Method  @"chat/roomshow/showLiveBtn4Mobile"

//隐身设置
#define InvisibleState_Method       @"base/userinfo/updateCurrUserHidden"

//提交同意协议页面
#define SubmitAgreeAllShow          @"chat/roomshow/submitAgreeallshow"

//显示同意协议页面
#define AgreeAllShow                @"chat/roomshow/agreeallshow"

//手机用户获取直播服务器信息
#define GetRoomServerForMobileStar_Method  @"chat/roomshow/selectRoomServer4MobileStar"

//开播
#define BeginShowAjax4Mobile_Method @"chat/roomshow/beginShowAjax4Mobile"

//停播
#define  EndShowAjax_Method         @"chat/roomshow/endShowAjax"

//充值记录
#define UserBuyHistory              @"usercenter/buycoin/myBuyCoinQuery"

//连续登陆
#define Loginreward              @"loginreward/rewards"

//设置当前签名
#define  UpdateIntroduction       @"admin/user/updateIntroduction"

//设置海报
#define  UpdateRoomshowImg       @"admin/user/updateRoomshowImg.talent"

//提现初始界面
#define  InitView_Method       @"chat/beantomoney/initView"

//提现确认
#define  ConfirmTx_Method        @"chat/beantomoney/autoConfirmTx"

//提现记录
#define  PageQuery_Method       @"chat/beantomoney/pageQuery"

//获取系统参数
#define  SelByPaiamnane_Method       @"admin/param/selectByParamname"

#endif