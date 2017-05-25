//
//  RedpacketTypeAdvertisementHandle.m
//  RedpacketLib
//
//  Created by 都基鹏 on 16/9/12.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import "RedpacketTypeAdvertisementHandle.h"
#import "RPRedpacketModel.h"
@implementation RedpacketTypeAdvertisementHandle

- (void)getRedpacketDetail {
    [super getRedpacketDetail];
    [self showRedPacketDetailViewController:self.messageModel];
    //fixnew
    //[[RedpacketDataRequester alloc]analysisADDataWithADName:@"rp.hb.ad.open_hb" andADID:model.rpID];
}

@end
