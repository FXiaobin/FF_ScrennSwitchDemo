//
//  SingleViewController.m
//  FF_ScrennSwitch
//
//  Created by fanxiaobin on 2017/12/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "SingleViewController.h"

#import "PlayerView.h"


// 用到的两个宏：
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@interface SingleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) BOOL isFull;

@property  (nonatomic,strong) PlayerView *playerView;

@property  (nonatomic,strong) UITableView *tableView;

@end

@implementation SingleViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个视频",(long)indexPath.row];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, self.view.bounds.size.height - 300)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.playerView = [[PlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    
    __weak typeof(self) weakSelf = self;
    self.playerView.playerBtnActionBlock = ^(PlayerView *aPlayerView, NSInteger index) {
        if (index == 0) {
            NSLog(@"---- 播放 ----");
            
        }else if (index == 1){
            [weakSelf swithchScreen];
            
        }else if (index == 2){
            NSLog(@"---- 返回 ----");
            if (weakSelf.isFull) {
                weakSelf.isFull = YES;
                [weakSelf swithchScreen];
            }else{
                [weakSelf.navigationController popViewControllerAnimated:YES];
               // [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        }
    };
    [self.view addSubview:self.playerView];
}

- (void)swithchScreen{
    _isFull = !_isFull;
    if (_isFull) {
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        [self interfaceOrientation:UIInterfaceOrientationPortrait];
    }
    
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return _isFull ? UIInterfaceOrientationMaskLandscapeRight : UIInterfaceOrientationMaskPortrait;
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)deviceOrientationDidChange{
    NSLog(@"deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        [self orientationChange:NO];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        [self orientationChange:YES];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)orientationChange:(BOOL)landscapeRight{
    if (landscapeRight) {
        [UIView animateWithDuration:0.2f animations:^{
            self.playerView.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.playerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            self.playerView.transform = CGAffineTransformMakeRotation(0);
            self.playerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 300);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
