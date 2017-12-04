//
//  PlayerView.h
//  FF_ScrennSwitch
//
//  Created by fanxiaobin on 2017/12/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerView : UIView

@property  (nonatomic,strong) UIView *bottomMaskView;
@property  (nonatomic,strong) UIView *bgView;


@property  (nonatomic,strong) UIButton *playBtn;

@property  (nonatomic,strong) UISlider *progressSlider;

@property  (nonatomic,strong) UILabel *startTimeLabel;

@property  (nonatomic,strong) UILabel *endTimeLabel;

@property  (nonatomic,strong) UIButton *fullBtn;

@property  (nonatomic,strong) UIButton *backBtn;

@property (nonatomic,copy) void (^playerBtnActionBlock) (PlayerView *aPlayerView,NSInteger index);

@end
