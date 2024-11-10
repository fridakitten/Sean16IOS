//
// sean16.h
//
// Created by SeanIsNotAConstant on 08.11.24
//
 
#include <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TouchTracker : NSObject

@property (nonatomic, assign) CGPoint touchPosition;
@property (nonatomic, assign) NSInteger lastTouchState;

- (instancetype)initWithView:(UIView *)view scale:(CGFloat)scale;
- (void)startTracking;
- (void)stopTracking;
- (CGPoint*)getPos;
- (NSInteger*)getBtn;

@end
TouchTracker *getTracker(void *arg);
void send_cpu(uint8_t);

@interface MyScreenEmulatorView : UIView

- (instancetype)initWithFrame:(CGRect)frame screenWidth:(NSInteger)width screenHeight:(NSInteger)height;
- (void)setPixelAtX:(NSInteger)x y:(NSInteger)y colorIndex:(NSUInteger)colorIndex;
- (UIColor *)colorAtPixelX:(NSInteger)x y:(NSInteger)y;
- (NSInteger)colorIndexAtPixelX:(NSInteger)x y:(NSInteger)y;
- (void)clear;

@end

MyScreenEmulatorView *getEmulator(void);

void kickstart(NSString *path);