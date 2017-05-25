//
//  RPMyIncomeHeaderVIew.m
//  RedpacketLib
//
//  Created by Mr.Yan on 2016/10/31.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import "RPMyIncomeHeaderView.h"
#import "RPLayout.h"
#import "UIView+YZHExtension.h"
#import "RedpacketColorStore.h"
#import "UIImageView+YZHWebCache.h"
#import "RPRedpacketTool.h"
#import "RPRedpacketModel.h"


@interface RPMyIncomeHeaderView ()
@end

@implementation RPMyIncomeHeaderView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews
{
    [self.headImageView rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.top.equalTo(self.rpm_top).offset(47);
        make.centerX.equalTo(self.rpm_centerX).offset(0);
        make.width.offset(57);
        make.height.offset(57);
    }];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill; 
    self.headImageView.layer.cornerRadius = 57 / 2.0f;
    self.headImageView.layer.masksToBounds = YES;
    [self.headImageView rp_setImageWithURL:[NSURL URLWithString:[RPRedpacketAliauth redpacketCurrentUser].avatar] placeholderImage:rpRedpacketBundleImage(@"redpacket_header")];
    
    [self.themeDescribeLable rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.top.equalTo(self.headImageView.rpm_bottom).offset(14);
        make.centerX.equalTo(self.rpm_centerX).offset(0);
    }];
    [self.moneyLable rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.top.equalTo(self.themeDescribeLable.rpm_bottom).offset(24);
        make.centerX.equalTo(self.rpm_centerX).offset(0);
        make.height.offset(40);
    }];
    
    // send
    [self.sendNumbersLable rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.bottom.equalTo(self.rpm_bottom).offset(-38.5);
        make.centerX.equalTo(self.rpm_centerX).offset(0);
    }];
    
    // receive
    [self.receiveDescribeLable rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-11);
        make.left.equalTo(self.rpm_left).offset(0);
        make.right.equalTo(self.rpm_centerX).offset(0);
    }];
    self.receiveDescribeLable.text = @"收到红包";
    
    [self.receiveNumbersLable rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.bottom.equalTo(self.receiveDescribeLable.rpm_top).offset(-11);
        make.left.equalTo(self.rpm_left).offset(0);
        make.right.equalTo(self.rpm_centerX).offset(0);
    }];
    
    [self.bestLuckyDescibeLable rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.bottom.equalTo(self.receiveDescribeLable);
        make.left.equalTo(self.rpm_centerX).offset(0);
        make.right.equalTo(self.rpm_right).offset(0);
    }];
    self.bestLuckyDescibeLable.text = @"手气最佳";
    
    [self.bestLuckyNumbersLable rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.bottom.equalTo(self.receiveNumbersLable);
        make.left.equalTo(self.rpm_centerX).offset(0);
        make.right.equalTo(self.rpm_right).offset(0);
    }];
    
    UIView * lineView = [self rp_addsubview:[UIView class]];
    lineView.backgroundColor = [RedpacketColorStore rp_lineColorLightGray];
    [lineView rpm_makeConstraints:^(RPConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.offset(RP_(@(0.5)).floatValue);
        make.bottom.equalTo(self);
    }];
}

- (void)setPersonalRedpacketType:(RPPersonalRedpacketType)personalRedpacketType
{
    _personalRedpacketType = personalRedpacketType;
    self.sendNumbersLable.hidden = personalRedpacketType != RPPersonalRedpacketTypeSend;
    self.receiveNumbersLable.hidden = personalRedpacketType == RPPersonalRedpacketTypeSend;
    self.receiveDescribeLable.hidden = personalRedpacketType == RPPersonalRedpacketTypeSend;
    self.bestLuckyNumbersLable.hidden = personalRedpacketType == RPPersonalRedpacketTypeSend;
    self.bestLuckyDescibeLable.hidden = personalRedpacketType == RPPersonalRedpacketTypeSend;
    self.themeDescribeLable.text = [NSString stringWithFormat:@"%@%@", [RPRedpacketAliauth redpacketCurrentUser].userName,self.personalRedpacketType == RPPersonalRedpacketTypeSend?@"共发出":@"共收到"];
}

- (void)setPersonalRedpacketInfo:(RPPersonalRedpacketInfo *)personalRedpacketInfo
{
    _personalRedpacketInfo = personalRedpacketInfo;
    NSString *money = personalRedpacketInfo.totalSendMoney;
    if (!money)  return;
    
    if (money.length == 0) {
        money = @"0.00";
    }
    self.moneyLable.text = [@"¥ " stringByAppendingString:money];
    if (self.personalRedpacketType == RPPersonalRedpacketTypeSend) {
        NSString *string;
        string = [NSString stringWithFormat:@"发出红包%ld个",personalRedpacketInfo.totalSendCount];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        [str addAttribute:NSForegroundColorAttributeName value:[RedpacketColorStore rp_textColorBlack] range:NSMakeRange(0,4)];
        [str addAttribute:NSForegroundColorAttributeName value:[RedpacketColorStore rp_textColorBlack] range:NSMakeRange(string.length - 1,1)];
        [str addAttribute:NSForegroundColorAttributeName value:[RedpacketColorStore rp_textColorRed] range:NSMakeRange(4,string.length - 5)];
        self.sendNumbersLable.attributedText = str;
    }else
    {
        self.bestLuckyNumbersLable.text = [NSString stringWithFormat:@"%ld",(long)personalRedpacketInfo.bestReceiveCount];
        self.receiveNumbersLable.text = [NSString stringWithFormat:@"%ldf",personalRedpacketInfo.totalReceiveCount];
    }

}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [self rp_addsubview:[UIImageView class]];
        _headImageView.backgroundColor = [RedpacketColorStore rp_backGroundGrayColor];
    }
    return _headImageView;
}

- (UILabel *)themeDescribeLable
{
    if (!_themeDescribeLable) {
        _themeDescribeLable = [self rp_addsubview:[UILabel class]];
        _themeDescribeLable.font = [UIFont systemFontOfSize:15.0f];
        _themeDescribeLable.textColor = [RedpacketColorStore rp_textColorBlack6];
    }
    return _themeDescribeLable;
}

- (UILabel *)moneyLable
{
    if (!_moneyLable) {
        _moneyLable = [self rp_addsubview:[UILabel class]];
        _moneyLable.font = [UIFont systemFontOfSize:44.0f];
        _moneyLable.textColor = [RedpacketColorStore rp_textColorBlack];
        _moneyLable.text = @"¥ 0.00";
    }
    return _moneyLable;
}

- (UILabel *)receiveNumbersLable
{
    if (!_receiveNumbersLable) {
        _receiveNumbersLable = [self rp_addsubview:[UILabel class]];
        _receiveNumbersLable.font = [UIFont systemFontOfSize:36.0f];
        _receiveNumbersLable.textColor = [RedpacketColorStore rp_textColorGray];
        _receiveNumbersLable.textAlignment = NSTextAlignmentCenter;
        _receiveNumbersLable.text = @"0";
    }
    return _receiveNumbersLable;
}

- (UILabel *)receiveDescribeLable
{
    if (!_receiveDescribeLable) {
        _receiveDescribeLable =[self rp_addsubview:[UILabel class]];
        _receiveDescribeLable.font = [UIFont systemFontOfSize:13.0f];
        _receiveDescribeLable.textColor = [RedpacketColorStore rp_textColorGray];
        _receiveDescribeLable.textAlignment = NSTextAlignmentCenter;
    }
    return _receiveDescribeLable;
}

- (UILabel *)bestLuckyNumbersLable
{
    if (!_bestLuckyNumbersLable) {
        _bestLuckyNumbersLable = [self rp_addsubview:[UILabel class]];
        _bestLuckyNumbersLable.font = [UIFont systemFontOfSize:36.0f];
        _bestLuckyNumbersLable.textColor = [RedpacketColorStore rp_textColorGray];
        _bestLuckyNumbersLable.textAlignment = NSTextAlignmentCenter;
        _bestLuckyNumbersLable.text = @"0";
    }
    return _bestLuckyNumbersLable;
}

- (UILabel *)bestLuckyDescibeLable
{
    if (!_bestLuckyDescibeLable) {
        _bestLuckyDescibeLable = [self rp_addsubview:[UILabel class]];
        _bestLuckyDescibeLable.font = [UIFont systemFontOfSize:13.0f];
        _bestLuckyDescibeLable.textColor = [RedpacketColorStore rp_textColorGray];
        _bestLuckyDescibeLable.textAlignment = NSTextAlignmentCenter;
    }
    return  _bestLuckyDescibeLable;
}

- (UILabel *)sendNumbersLable
{
    if (!_sendNumbersLable) {
        _sendNumbersLable = [self rp_addsubview:[UILabel class]];
        _sendNumbersLable.font = [UIFont systemFontOfSize:15.0f];
    }
    return _sendNumbersLable;
}

@end
