//
/******************************************************************************************/
//   共同方法



#import <Foundation/Foundation.h>



@interface CommonUtils : NSObject


/****************** 关于字符串方法 ******************/

/* 
 获取一个UUID字符串
 */
+ (NSString *)createUUID;

/* 
 获取对象的字符串类型 
 */
+ (NSString *)stringForId:(id)object;

/*
 判断空字符串
 */
+ (BOOL)isEmpty:(NSString *)string;

/*
 字符串MD5加密
 */
+ (NSString *)md5Encrypt:(NSString *)password;

/* 
 URL字符串中获取文件名
 */
+ (NSString *)getFileNameByUrl:(NSString *)url;

/* 
 获取Localizable中数据
 */
+ (NSString *)getLocalizable:(NSString *)name;


/****************** 关于网络方法  ******************/

/* 
 检测网络 (注：NotReachable.没有网络 ReachableViaWWAN.正在使用3G网络 ReachableViaWiFi.正在使用wifi网络) 
 */
//+ (NetworkStatus)checkNetwork;


/**************** 关于"NSUserDefaults"快捷方法 **********************/

// 保存数据——NSUserDefaults
+ (void)setInfoObject:(id)object forKey:(NSString *)key;

// 取得数据——NSUserDefaults
+ (id)getInfoObject:(NSString *)key;

// 删除数据——NSUserDefaults
+ (void)delInfoObject:(NSString *)key;



/****************** 关于绘图方法 ******************/

// 添加圆角和边框
+ (void)addShadowForView:(UIView *)view toRadius:(NSInteger)radius toBorderWidth:(NSInteger)width toColor:(UIColor *)color;



/****************** 关于警告/提示 ******************/

///* 温馨提示 */
//+ (void)showTips:(NSString *)message;

/* 警告提示 */
+ (void)showAlertView:(NSString *)message;

/* 警告提示，可以设置回调方法 */
+ (void)showAlertView:(NSString *)message delegate:(id)delegate;



/* 获取设备型号 */
+ (NSString *)platformStringsss;


/* ios去掉字符串中的html标签的方法 */
+ (NSString *)filterHTML:(NSString *)html;

/* 检查手机号    return正确手机号 */
+ (BOOL)checkMobile:(NSString *)_text;

/* 检查手机号码位数 */
+ (BOOL)checkPhoneNumberCountWithCurrentTextField:(UITextField*)currentTextFiled withTargetTextField:(UITextField*)targerTextField;

/* 检查姓名中含有数字标点 */
+ (BOOL)checkShuZiWithBiaoDianWithString:(NSString*)string;

/* 格式化手机号 */  //  手机号    需要格式化的字符
+ (NSString*)changePhoneNumberWithNumber:(NSString*)number withType:(NSString*)type;


/* 检查是否是数字和小数点,只能有一个小数点 */  //YES return；
+ (BOOL)checkNumber:(NSString *)string WithTextFieldText:(NSString*)text;

/* 检查匹配由数字和26个英文字母组成的字符串*/  //YES return；
+(BOOL)checkStringNumbersWithlettersWithString:(NSString*)string;
+(void)heightForText:(NSString *)text withFontSize:(CGFloat)size withWide:(CGFloat)wide withBlocl:(void (^)(CGFloat))block;

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
@end
