//
//  LoopView.m
//  LoopView
//
//  Created by cnsue on 2017/3/21.
//  Copyright © 2017年 cnsue. All rights reserved.
//

#import "LoopView.h"

@interface LoopCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * imageView;
@end
@implementation LoopCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            [self addSubview:imageView];
            imageView;
        });
    }
    return self;
}

- (void)updateCollectionViewCellWithInfo:(NSString *)info
{
    [self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",info]]];
}

@end




@interface LoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong,readonly)UICollectionView *collectionView;

@property(nonatomic,strong,readonly)NSMutableArray *dataArr;

@property (nonatomic,strong,readonly) UIPageControl *pageControl;
@end

@implementation LoopView
@synthesize collectionView = _collectionView;
@synthesize dataArr = _dataArr;
@synthesize pageControl = _pageControl;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

-(void)setUpView
{
    [self.collectionView registerClass:[LoopCell class] forCellWithReuseIdentifier:@"loopCellIdentifier"];
    [self addSubview:self.pageControl];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    self.pageControl.numberOfPages = self.imageArr.count;
}

#pragma mark ------------property---------------

-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.f;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds) - 100, CGRectGetMaxY(self.bounds) - 50, 200, 40)];
        _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    }
    return _pageControl;
}

-(NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithObject:[self.imageArr lastObject]];
        [_dataArr addObjectsFromArray:self.imageArr];
        [_dataArr addObject:[self.imageArr firstObject]];
    }
    return _dataArr;
}

#pragma mark -------------delegate----------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LoopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loopCellIdentifier" forIndexPath:indexPath];
    [cell updateCollectionViewCellWithInfo:[self.dataArr objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.item);
    NSLog(@"点击了%@图片",[self.dataArr objectAtIndex:indexPath.row]);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = (scrollView.contentOffset.x / CGRectGetWidth(self.frame)) - 1;
    self.pageControl.currentPage = currentPage;
    if (currentPage < 0) {
        self.pageControl.currentPage = self.imageArr.count - 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageArr.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    else if (currentPage == self.imageArr.count){
        self.pageControl.currentPage = 0;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}

@end
