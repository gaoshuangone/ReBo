//
//  MyAttendViewController.m
//  BoXiu
//
//  Created by andy on 14-8-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MyAttendViewController.h"
#import "EWPTabMenuControl.h"

@interface MyAttendViewController ()<EWPTabMenuControlDataSource,EWPTabMenuControlDelegate>
@property (nonatomic,strong) EWPTabMenuControl *tabMenuControl;
@property (nonatomic,strong) NSArray *tabMenuTitles;
@property (nonatomic,strong) NSMutableArray *contentViewControllerMArray;
@property (nonatomic,assign) NSInteger currentTabIndex;

@property (nonatomic,assign) BOOL bTapTabItem;

@end

@implementation MyAttendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _contentViewControllerMArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的关注";
    _tabMenuTitles = [[NSArray alloc] initWithObjects:@"我关注的",@"看过的", nil];
    
    
    [self initContentView];
    
    
    _tabMenuControl = [[EWPTabMenuControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tabMenuControl.dataSource = self;
    _tabMenuControl.delegate = self;
    _tabMenuControl.defaultSelectedSegmentIndex = 0;
    [self.view addSubview:_tabMenuControl];

     [_tabMenuControl reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initContentView
{
    [self.contentViewControllerMArray removeAllObjects];
    
    Class contentViewControllerType = NSClassFromString(Attent_Canvas);
    ViewController *viewController = (ViewController *)[[contentViewControllerType alloc] init];
    viewController.rootViewController = self;
    [self.contentViewControllerMArray addObject:viewController];
    
    contentViewControllerType = NSClassFromString(History_Canvas);
    viewController = [[contentViewControllerType alloc] init];
    viewController.rootViewController = self;
    [self.contentViewControllerMArray addObject:viewController];
}

#pragma mark - EWPTabMenuDataSource

- (EWPSegmentedControl *)ewpSegmentedControl
{
    EWPSegmentedControl *segmentedControl = [[EWPSegmentedControl alloc] initWithSectionTitles:_tabMenuTitles];
    segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 36);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.backgroundColor = [UIColor clearColor];
    segmentedControl.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    segmentedControl.selectionStyle = EWPSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [CommonFuction colorFromHexRGB:@"55BB22"];
    segmentedControl.selectedTextColor = [CommonFuction colorFromHexRGB:@"55BB22"];
    segmentedControl.selectionIndicatorHeight = 1.5f;
    segmentedControl.font = [UIFont systemFontOfSize:14.0f];
    return segmentedControl;
}

- (UIViewController *)ewpTabMenuControl:(EWPTabMenuControl *)ewpTabMenuControl tabViewOfindex:(NSInteger)index
{
    UIViewController *itemViewController = nil;
    if (self.contentViewControllerMArray && [self.contentViewControllerMArray count] > index)
    {
        itemViewController = [self.contentViewControllerMArray objectAtIndex:index];
    }
    return itemViewController;
}

#pragma mark - EWPTabMenuDelegate

- (void)progressEdgePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer tabMenuOfIndex:(NSInteger)index
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
