//
//  RMImageScrollView.m
//  RMImageScrollView
//
//  Created by JianRongCao on 1/6/16.
//  Copyright © 2016 JianRongCao. All rights reserved.
//

#import "RMImageScrollView.h"

@interface RMImageScrollView ()<UIScrollViewDelegate>
{
    
}
@property (nonatomic, strong) UIScrollView *imageScrollView;

@property (nonatomic, strong) UIImageView *sourceView;

@end

@implementation RMImageScrollView

- (void)setImage:(NSString *)url placeholderImage:(UIImage *)placeholderImage
{
    
}

- (void)doubleTap:(UIGestureRecognizer *)gesture
{
    [self performSelector:@selector(hiddenBigImage) withObject:Nil afterDelay:0.3];
}

- (void)hiddenBigImage
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.subviews valueForKey:@"removeFromSuperview"];
    [self removeFromSuperview];
}

#pragma mark
-(void)changeOrientation:(NSNotification *)notification
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    UIDeviceOrientation orientatin = [[UIDevice currentDevice] orientation];
    if (orientatin == UIInterfaceOrientationPortrait || orientatin == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"竖屏");
        self.imageScrollView.transform = CGAffineTransformMakeRotation(0);
        self.imageScrollView.frame = CGRectMake(0, 0, width, height);
        self.imageScrollView.contentSize = CGSizeMake(width, height);
        self.sourceView.frame = CGRectMake(0, 0, width, height);
    } else if (orientatin == UIInterfaceOrientationLandscapeLeft) {
        NSLog(@"横屏1");
        self.imageScrollView.transform = CGAffineTransformMakeRotation(-M_PI/2.0);
        self.imageScrollView.frame = CGRectMake(0, 0, width, height);
        self.imageScrollView.contentSize = CGSizeMake(width, height);
        self.sourceView.frame = CGRectMake(0, 0, height, width);
    } else if (orientatin == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"横屏2");
        self.imageScrollView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
        self.imageScrollView.frame = CGRectMake(0, 0, width, height);
        self.imageScrollView.contentSize = CGSizeMake(width, height);
        self.sourceView.frame = CGRectMake(0, 0, height, width);
    }
    [self.imageScrollView setZoomScale:1.0 animated:YES];
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.sourceView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    UIImage *img = self.sourceView.image;
    if (img.size.width > self.frame.size.width || img.size.height > self.frame.size.height) {
        self.sourceView.frame = view.frame;
    } else {
        self.sourceView.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    }
    
    self.imageScrollView.contentSize = view.frame.size;
    if(scale <= 1.0){
        self.sourceView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) ;
    }
}

#pragma mark Get/Set Method
- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.imageScrollView.backgroundColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeOrientation:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.imageScrollView.backgroundColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeOrientation:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    return self;
}

- (UIScrollView *)imageScrollView
{
    if (!_imageScrollView) {
        _imageScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _imageScrollView.delegate = self;
        _imageScrollView.maximumZoomScale = 3.0;
        _imageScrollView.minimumZoomScale = 0.5;
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_imageScrollView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        tap.numberOfTapsRequired = 2;
        [_imageScrollView addGestureRecognizer:tap];
    }
    return _imageScrollView;
}

- (UIImageView *)sourceView
{
    if (!_sourceView) {
        _sourceView = [[UIImageView alloc] initWithFrame:self.bounds];
        _sourceView.backgroundColor = [UIColor blackColor];
        _sourceView.contentMode = UIViewContentModeScaleAspectFit;
        _sourceView.userInteractionEnabled = YES;
        [self.imageScrollView addSubview:_sourceView];
    }
    return _sourceView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.sourceView setImage:image];
    [self.sourceView setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    self.sourceView.center = CGPointMake(self.imageScrollView.center.x, self.imageScrollView.center.y);
    NSLog(@"%@",NSStringFromCGPoint(self.sourceView.center));
}

@end
