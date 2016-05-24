//
//  .h
//  BoXiu
//
//  Created by Andy on 14-4-2.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEnterRoomModel.h"
@interface UserProp : NSObject
@property (nonatomic,strong) NSString *propname;
@property (nonatomic,strong) NSString *propurl;
@property (nonatomic,strong) NSString *propid;
@end

@interface UserInfo: NSObject
@property (nonatomic,assign) NSInteger userId; //用户ID
@property (nonatomic,assign) NSInteger idxcode;//靓号
@property (nonatomic,assign) NSInteger idxcodedefault;
@property (nonatomic,strong) NSString *loginname;   //登录名
@property (nonatomic,strong) NSString *clientId;
@property (nonatomic,strong) NSString *nick;        //昵称
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,strong) NSString *province;    //省
@property (nonatomic,strong) NSString *provincename;
@property (nonatomic,strong) NSString *city;        //市
@property (nonatomic,strong) NSString *cityname;
@property (nonatomic,assign) long long coin;
@property (nonatomic,assign) long long bean;
@property (nonatomic,assign) long long stargetcoin;
@property (nonatomic,assign) BOOL isstar;       //是否是明星
@property (nonatomic,assign) BOOL issupermanager;//是否是超管
@property (nonatomic,assign) BOOL managerflag;
@property (nonatomic,assign) BOOL iswatchmanager;
@property (nonatomic,assign) BOOL isPurpleVip;  //紫色会员
@property (nonatomic,assign) BOOL isYellowVip;  //黄色会员
@property (nonatomic,assign) NSInteger type;  //区分人和机器人

/**
 *用户明星等级（之前的聊天内容不区分用户和主播，后来又区分，但是解析数据用useInfor来解析，会出现临时的主播信息）
 */
@property (nonatomic,assign) NSInteger userStarlevelid;

@property (nonatomic,assign) int levelid;
@property (nonatomic,strong) NSMutableArray *userPropMArray;//道具属性集

@property (nonatomic,assign) NSInteger passwordnotset;   //自动注册时需要判断用户是否自己设置过密码 1 未设置 其它代表已设置
@property (nonatomic,strong) NSString *password;  //服务器返回加密过的密码
@property (nonatomic,assign) NSInteger hidden;      //是否隐身 1是显身 2是隐身
@property (nonatomic,strong) NSString *hiddenindex;//隐身用户昵称
//这连个可能多余，然后要删掉
@property (nonatomic,strong) NSString *userGrade;
@property (nonatomic,strong) NSString *mainActorGrade;

@property (nonatomic,assign) NSInteger privlevelweight;//当前vip最高等级
@property (nonatomic,assign) NSInteger consumerlevelweight;//当前财富最高等级

@property (nonatomic,assign) NSInteger clevelnextweight;
@property (nonatomic,assign) long long clevelnextweightcoin;
@property (nonatomic,assign) long long clevelweightcoin;
@property (nonatomic,assign) long long costcoin;
@property (nonatomic,assign) int cpercent;

@property (nonatomic,assign) NSInteger levelWeight;
@property (nonatomic,assign) NSInteger realUserId;
@property (nonatomic,assign) long long time;
@property (nonatomic,assign) NSInteger staruserid;

//赞的个数
@property (nonatomic,assign) NSInteger leavecount;
@property (nonatomic,assign) NSInteger getcount;
@property (nonatomic,assign) NSInteger sendcount;
@property (nonatomic,assign) NSInteger maxcount;
@property (nonatomic,strong) NSString *token;//只有用户登录才有，否则为空
@property (nonatomic,strong)CarData * cardata;
//实名认证
//如果没有该字段，则表示该用户没有申请过实名认证，若有值，则该字段的含义如下
@property (nonatomic,assign) NSInteger authstatus;//1: 待审核，2：审核通过，3：审核不通过

@property (nonatomic,strong) NSArray *rewards;//受邀用户第一次登录，有值，否则没有

@property (assign, nonatomic) CGPoint pointTouch;


@property (nonatomic,strong) NSString* introduction;//签名


+ (NSInteger)switchConsumerlevelweight:(NSInteger)consumerlevelweight;

@end

@interface StarInfo : UserInfo
@property (nonatomic,assign) NSInteger starid;
@property (nonatomic,strong) NSString *adphoto;//大厅美女热推大图片
@property (nonatomic,strong) NSString *roomad;//房间公告
@property (nonatomic,assign) NSInteger attentionnum;//关注数
@property (nonatomic,assign) NSInteger fansnum;  //粉丝数
@property (nonatomic,assign) NSInteger fansnumtoplimit; //粉丝上限(?)
@property (nonatomic,strong) NSString *liveip;
@property (nonatomic,strong) NSString *livestream;
@property (nonatomic,assign) NSInteger recommendflag;
@property (nonatomic,assign) NSInteger roomid;
@property (nonatomic,assign) NSInteger starlevelid;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) NSInteger showusernum;
@property (nonatomic,strong) NSString *serverip;//明星直播vip
@property (nonatomic,assign) NSInteger serverport;//明星直播端口号
@property (nonatomic,strong) NSString *showbegintime;
@property (nonatomic,assign) NSInteger starlevelnextid;
@property (nonatomic,assign) long long starlevelnextcoin;
@property (nonatomic,assign) NSInteger starlevelpercent;
@property (nonatomic,assign) long long starlevelcoin;
@property (nonatomic,assign) long long getcoin;
@property (nonatomic) BOOL attentionflag;
@property (nonatomic) BOOL onlineflag;

@property (nonatomic,assign) NSInteger count;//直播间人数
@property (nonatomic,assign) NSInteger rsstatus;
@property (nonatomic,assign) NSInteger firstnewstarflag;
@property (nonatomic,assign) NSInteger newstarflag;

//主播赞数
@property (nonatomic,assign) NSInteger starmonthpraisecount;

@property (nonatomic,assign) NSInteger praisecount;

@property (nonatomic,strong) NSString *introduction;
@property (nonatomic,strong) NSString *timeago;
@property (nonatomic,strong) NSString *mylink;
@property (nonatomic,strong) NSString *isbeantomoneydisplay;//提现开关 1开着  2 关闭
@property (strong, nonatomic)NSString* roomfmt;//直播分辨率

@end