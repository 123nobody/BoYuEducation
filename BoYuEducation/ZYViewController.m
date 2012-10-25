//
//  ZYViewController.m
//  BoYuEducation
//
//  Created by Wei on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZYViewController.h"

////菜单table宽高
//#define BY_MENU_HEIGHT 50.f
//#define BY_MENU_WIDTH 200.f
//菜单table cell宽高
#define BY_MENUCELL_HEIGHT 50.f
#define BY_MENUCELL_WIDTH 200.f
//菜单cell平移步长
#define BY_MENUCELL_MOVE_LENGHT 30.f
//菜单table cell tab宽高
#define BY_MENUCELL_TAB_HEIGHT 15.f
#define BY_MENUCELL_TAB_WIDTH 40.f
//menutable 左上边距
#define BY_MENUTABLE_MARGIN_LEFT 0.f
#define BY_MENUTABLE_MARGIN_TOP 50.f
//centerView宽高
#define BY_CENTERVIEW_HEIGHT 748.f
#define BY_CENTERVIEW_WIDTH 450.f
//centerView平移步长
#define BY_CENTERVIEW_MOVE_LENGHT 100.f

@interface ZYViewController ()

@end

@implementation ZYViewController

@synthesize menuTable = _menuTable;
@synthesize cellContents = _cellContents;
@synthesize cellTabViews = _cellTabViews;
@synthesize centerView = _centerView;
@synthesize backView = _backView;
@synthesize gridView = _gridView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"load example view, frame: %@", NSStringFromCGRect(self.view.frame));
    
    self.view.exclusiveTouch = YES;
    [self initMenuTableView];
    [self initBackView];
    [self initCenterView];
    

    return;
}

//初始化menuTableView
- (void)initMenuTableView
{
    _cellTabViews = [[NSMutableArray alloc]init];
    
    _cellContents = [[NSArray alloc]initWithObjects:@"", @"     培训课程", @"     在线调查", @"     在线考试", nil];
    
    _menuTable = [[UITableView alloc]initWithFrame:CGRectMake(BY_MENUTABLE_MARGIN_LEFT, BY_MENUTABLE_MARGIN_TOP, BY_MENUCELL_WIDTH, (BY_MENUCELL_HEIGHT * (_cellContents.count - 1) + BY_MENUCELL_TAB_HEIGHT)) style:UITableViewStylePlain];
    _menuTable.delegate = self;
    _menuTable.dataSource = self;
    _menuTable.exclusiveTouch = YES;
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//    [_menuTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    NSLog(@"begin select %d", [_menuTable indexPathForSelectedRow].row);
    
    _menuTable.backgroundColor = [UIColor lightGrayColor];
    
    
    [self.view addSubview:_menuTable];
    [_menuTable reloadData];
}

//初始化centerView
- (void)initCenterView
{
    _centerView = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 450, 748)];
    _centerView.backgroundColor = [UIColor greenColor];
    _centerView.userInteractionEnabled = YES;
    _centerView.exclusiveTouch = YES;
    
//    //添加手势
//    UISwipeGestureRecognizer *recognizer;
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    [_centerView addGestureRecognizer:recognizer];
//    [recognizer release];
//    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
//    [_centerView addGestureRecognizer:recognizer];
//    [recognizer release];
    
    [self.view addSubview:_centerView];
    
}

//初始化backView
- (void)initBackView
{
    _backView = [[UIView alloc]initWithFrame:CGRectMake((BY_MENUTABLE_MARGIN_LEFT + BY_MENUCELL_WIDTH + BY_CENTERVIEW_WIDTH), 0, (1024 - BY_MENUTABLE_MARGIN_LEFT - BY_MENUCELL_WIDTH - BY_CENTERVIEW_WIDTH), 748)];
    _backView.exclusiveTouch = YES;
//    _backView.backgroundColor = [UIColor darkGrayColor];
    
    NSMutableArray *appViewsArray = [[NSMutableArray alloc]init];
    
    UIImage *image_1 = [[UIImage imageNamed:@"08-chat.png"]autorelease];
    ZYAppView *appView_1 = [[[ZYAppView alloc]initWithImage:image_1 Name:@"营销工具"]autorelease];
    [appViewsArray addObject:appView_1];
    
    UIImage *image_2 = [[UIImage imageNamed:@"11-clock.png"]autorelease];
    ZYAppView *appView_2 = [[[ZYAppView alloc]initWithImage:image_2 Name:@"金融产品"]autorelease];
    [appViewsArray addObject:appView_2];
    
    UIImage *image_3 = [[UIImage imageNamed:@"15-tags.png"]autorelease];
    ZYAppView *appView_3 = [[[ZYAppView alloc]initWithImage:image_3 Name:@"计算器"]autorelease];
    [appViewsArray addObject:appView_3];
    
    UIImage *image_4 = [[UIImage imageNamed:@"11-clock.png"]autorelease];
    ZYAppView *appView_4 = [[[ZYAppView alloc]initWithImage:image_4 Name:@"更换皮肤"]autorelease];
    [appViewsArray addObject:appView_4];
    
    _gridView = [[ZYGridView alloc]initWithZYAppViews:appViewsArray];
    _gridView.exclusiveTouch = YES;
    
    //水平对齐
    CGRect backViewFrame = _backView.frame;
    CGRect gridViewFrame = _gridView.frame;
    gridViewFrame = CGRectMake(((backViewFrame.size.width - gridViewFrame.size.width) / 2), gridViewFrame.origin.y, gridViewFrame.size.width, gridViewFrame.size.height);
    [_gridView setFrame:gridViewFrame];
    
    [_backView addSubview:_gridView];
    
//    [image release];
//    [appView release];
    
    [self.view addSubview:_backView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _beginPoint = [[touches anyObject] locationInView:_centerView];
    if (_beginPoint.x > 0 && _beginPoint.x < _centerView.frame.size.width) {
        //记录第一个点，以便计算移动距离
        _centerView.tag = 1;
        NSLog(@"1111111");
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_centerView.tag == 1) {
        CGPoint pt = [[touches anyObject] locationInView:_centerView];
        // 计算移动距离，并更新图像的frame
        CGRect frame = _centerView.frame;
        frame.origin.x += pt.x - _beginPoint.x;
        //    frame.origin.y += pt.y - _beginPoint.y;
        [_centerView setFrame:frame]; 
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_centerView.tag == 1) {
        CGRect frame = _centerView.frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        if (_centerView.frame.origin.x >= 150) {
            frame.origin.x = BY_MENUTABLE_MARGIN_LEFT + BY_MENUCELL_WIDTH;
            [_centerView setFrame:frame];
            [self doBackViewAnimationWithRecognizerDirection:UISwipeGestureRecognizerDirectionRight];
        } else {
            frame.origin.x = BY_MENUTABLE_MARGIN_LEFT + BY_MENUCELL_WIDTH - BY_CENTERVIEW_MOVE_LENGHT;
            [_centerView setFrame:frame];
            [self doBackViewAnimationWithRecognizerDirection:UISwipeGestureRecognizerDirectionLeft];
        }
        
        [UIView commitAnimations];
        _centerView.tag = 0;
    }        
}

//centerView手势识别
//- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer 
//{
//    switch (recognizer.direction) {
//        case UISwipeGestureRecognizerDirectionLeft:
//        {
//            NSLog(@"left");
//            //移动centerView
//            [self doCenterViewAnimationWithRecognizer:recognizer];
//        }
//            break;
//            
//        case UISwipeGestureRecognizerDirectionRight:
//        {
//            NSLog(@"right");
//            [self doCenterViewAnimationWithRecognizer:recognizer];
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    // 底下是刪除手势的方法
//    //[self.view removeGestureRecognizer:recognizer];
//}

//backView适配动画
- (void)doBackViewAnimationWithRecognizerDirection: (UISwipeGestureRecognizerDirection)recognizerDirection
{
    CGRect centerViewFrame = _centerView.frame;
    CGRect backViewFrame = _backView.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    if (recognizerDirection == UISwipeGestureRecognizerDirectionLeft && _gridView.isInitStatic == YES) {
        backViewFrame = CGRectMake((centerViewFrame.origin.x + centerViewFrame.size.width), backViewFrame.origin.y, backViewFrame.size.width + BY_CENTERVIEW_MOVE_LENGHT, backViewFrame.size.height);
        _gridView.isInitStatic = NO;
    } else if (recognizerDirection == UISwipeGestureRecognizerDirectionRight && _gridView.isInitStatic == NO) {
        backViewFrame = CGRectMake((centerViewFrame.origin.x + centerViewFrame.size.width), backViewFrame.origin.y, backViewFrame.size.width - BY_CENTERVIEW_MOVE_LENGHT, backViewFrame.size.height);
        _gridView.isInitStatic = YES;
    }
    
    [_backView setFrame:backViewFrame];
    [UIView commitAnimations];
    NSLog(@"move backView.");
    
    //水平对齐gridView
    CGRect gridViewFrame = _gridView.frame;
    gridViewFrame = CGRectMake(((backViewFrame.size.width - gridViewFrame.size.width) / 2), gridViewFrame.origin.y, gridViewFrame.size.width, gridViewFrame.size.height);
    
    //动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [_gridView setFrame:gridViewFrame];
    [UIView commitAnimations];
    
}

//centerView动画
- (void)doCenterViewAnimationWithRecognizer: (UISwipeGestureRecognizer *)recognizer
{
    //动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = _centerView.frame;
    NSLog(@"frame:%@", NSStringFromCGRect(frame));
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft && frame.origin.x == 200) {
        frame.origin.x -= 100;
        [_centerView setFrame:frame];
//        [self doBackViewAnimationWithRecognizer:recognizer];
        NSLog(@"do left");
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight && frame.origin.x == 100) {
        frame.origin.x += 100;
        [_centerView setFrame:frame];
//        [self doBackViewAnimationWithRecognizer:recognizer];
        NSLog(@"do right");
    }
    
    //执行动画
    [UIView commitAnimations];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (index == 0) {
        [_cellTabViews addObject:[[UIView alloc]init]];
        return cell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [_cellContents objectAtIndex:index];
    
    CGRect frame;
    
    frame = cell.textLabel.frame;
    frame.size.width += BY_MENUCELL_MOVE_LENGHT;
    [cell.textLabel setFrame:frame];
    
    if (_cellTabViews.count < _cellContents.count) {
        frame = CGRectMake(50, (BY_MENUCELL_HEIGHT * (index - 1)), BY_MENUCELL_TAB_WIDTH, BY_MENUCELL_TAB_HEIGHT);
        UIView *tabView = [[UIView alloc]initWithFrame:frame];
        tabView.backgroundColor = [UIColor blueColor];
        
        [_cellTabViews addObject:tabView];
        
        [_menuTable addSubview:tabView];
        
        [tabView release];

    }
    
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 15.f;
    }
    return BY_MENUCELL_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellContents.count;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return nil;
    }
    NSLog(@"will Select Row %d", [tableView indexPathForSelectedRow].row);
    if ([tableView indexPathForSelectedRow].row == indexPath.row) {
        NSLog(@"This row is selecting.");
        return indexPath;
    }
    NSLog(@"selected row %d.", indexPath.row);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.frame = CGRectMake(0, 0, (BY_MENUCELL_WIDTH + BY_MENUCELL_MOVE_LENGHT), BY_MENUCELL_HEIGHT);
    cell.textLabel.backgroundColor = [UIColor redColor];
    
    //动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame;
    
    frame = cell.frame;
    frame.origin.x -= BY_MENUCELL_MOVE_LENGHT;
    [cell setFrame:frame];
    
    UIView *cellTabView = (UIView *)[_cellTabViews objectAtIndex:indexPath.row];
    frame = cellTabView.frame;
    frame.origin.x -= BY_MENUCELL_MOVE_LENGHT;
    [cellTabView setFrame:frame];
    //执行动画
    [UIView commitAnimations];
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"deselected row %d.", indexPath.row);
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView cellForRowAtIndexPath:indexPath].textLabel.backgroundColor = [UIColor lightGrayColor];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect frame = cell.frame;
    frame.origin.x += BY_MENUCELL_MOVE_LENGHT;
    [cell setFrame:frame];
    
    UIView *cellTabView = (UIView *)[_cellTabViews objectAtIndex:indexPath.row];
    CGRect cellTabFrame = cellTabView.frame;
    cellTabFrame.origin.x += BY_MENUCELL_MOVE_LENGHT;
    [cellTabView setFrame:cellTabFrame];
    
    [UIView commitAnimations];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [_menuTable release];
    [_menuTable dealloc];
    [_cellContents release];
    [_cellContents dealloc];
    [_cellTabViews release];
    [_cellTabViews dealloc];
    [_centerView release];
    [_centerView dealloc];
    [_backView release];
    [_backView dealloc];
    [_gridView release];
    [_gridView dealloc];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
