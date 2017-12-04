//
//  PlayerView.m
//  FF_ScrennSwitch
//
//  Created by fanxiaobin on 2017/12/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "PlayerView.h"
#import <Masonry.h>

@implementation PlayerView

-(UIView *)bottomMaskView{
    if (_bottomMaskView == nil) {
        _bottomMaskView = [UIView new];
    }
    return _bottomMaskView;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
    }
    return _bgView;
}

-(UIButton *)playBtn{
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] init];
        _playBtn.backgroundColor = [UIColor cyanColor];
        [_playBtn addTarget:self action:@selector(playerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.tag = 10000;
    }
    return _playBtn;
}

-(UIButton *)fullBtn{
    if (_fullBtn == nil) {
        _fullBtn = [[UIButton alloc] init];
        _fullBtn.backgroundColor = [UIColor cyanColor];
        [_fullBtn addTarget:self action:@selector(playerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _fullBtn.tag = 10001;
    }
    return _fullBtn;
}

-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] init];
        _backBtn.backgroundColor = [UIColor cyanColor];
        [_backBtn addTarget:self action:@selector(playerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.tag = 10002;
    }
    return _backBtn;
}

-(UISlider *)progressSlider{
    if (_progressSlider == nil) {
        _progressSlider = [UISlider new];
        _progressSlider.minimumValue = 0.0;
        _progressSlider.maximumValue = 1.0;
        _progressSlider.value = 0.0;
        [_progressSlider setThumbImage:[UIImage imageNamed:@"my_icon01"] forState:UIControlStateNormal];
    }
    return _progressSlider;
}

-(UILabel *)startTimeLabel{
    if (_startTimeLabel == nil) {
        _startTimeLabel = [UILabel new];
        _startTimeLabel.text = @"00:00:00";
        _startTimeLabel.font = [UIFont systemFontOfSize:10];
        _startTimeLabel.textColor = [UIColor whiteColor];
        
    }
    return _startTimeLabel;
}

-(UILabel *)endTimeLabel{
    if (_endTimeLabel == nil) {
        _endTimeLabel = [UILabel new];
        _endTimeLabel.text = @"00:00:00";
        _endTimeLabel.font = [UIFont systemFontOfSize:10];
        _endTimeLabel.textColor = [UIColor whiteColor];
        
    }
    return _endTimeLabel;
}

- (void)playerBtnAction:(UIButton *)sender{
    if (self.playerBtnActionBlock) {
        self.playerBtnActionBlock(self, sender.tag - 10000);
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:self.bottomMaskView];
        [self.bottomMaskView addSubview:self.bgView];
        [self addSubview:self.backBtn];
        [self.bottomMaskView addSubview:self.playBtn];
        [self.bottomMaskView addSubview:self.progressSlider];
        [self.bottomMaskView addSubview:self.startTimeLabel];
        [self.bottomMaskView addSubview:self.endTimeLabel];
        [self.bottomMaskView addSubview:self.fullBtn];
        
        [self.bottomMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(46.0);
        }];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bottomMaskView);
        }];
        
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(30);
            make.width.and.height.mas_equalTo(30.0);
        }];
        
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomMaskView).offset(10);
            make.centerY.equalTo(self.bottomMaskView);
            make.width.and.height.mas_equalTo(30.0);
        }];
        
        [self.fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bottomMaskView.mas_right).offset(-10);
            make.centerY.equalTo(self.bottomMaskView);
            make.width.and.height.mas_equalTo(30.0);
        }];
        
        [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBtn.mas_right).offset(10);
            make.centerY.equalTo(self.bottomMaskView).offset(-5);
            make.right.equalTo(self.fullBtn.mas_left).offset(-10);
        }];
        
        [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.progressSlider);
            make.top.equalTo(self.progressSlider.mas_bottom).offset(5);
        }];
        
        [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.progressSlider.mas_right);
            make.centerY.equalTo(self.startTimeLabel);
        }];
        
    }
    return self;
}

@end
