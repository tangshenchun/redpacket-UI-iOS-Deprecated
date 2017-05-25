//
//  MyInComeRedPacketViewController.h
//  ChatDemo-UI3.0
//
//  Created by Mr.Yang on 16/2/28.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import "RPRefreshTableViewController.h"
#import "RPRedpacketModel.h"
#import "RPMyIncomeRedPacketCell.h"

@interface MyInComeRedPacketViewController : RPRefreshTableViewController

@property (nonatomic,copy) NSDictionary * responseData;
@property (nonatomic, strong) RPPersonalRedpacketInfo *personalRedpacketInfo;
@property (nonatomic, assign) RPPersonalRedpacketType personalRedpacketType;

- (void)closeBarButtonSender;
- (void)requestRedpacketGetDetailReplacer;
- (void)requestRedpacketGetDetail;

- (NSArray *)currentRedpackets;

@end
