
@class SVDelayController;

@protocol SVDelayControllerDelegate <NSObject>

@optional
- (void)delayControllerDidFinishDelay:(SVDelayController *)controller;
- (void)delayControllerDidCancelDelay:(SVDelayController *)controller;

@end

@interface SVDelayController : NSObject {
    NSTimeInterval delayTime;
    id<SVDelayControllerDelegate> _delegate;
}

@property(nonatomic, assign)id<SVDelayControllerDelegate> delegate;
@property(nonatomic, readonly)NSTimeInterval delayTime;
@property(nonatomic, assign)NSInteger tag;

- (id)initWithInterval:(NSTimeInterval)interval;
- (void)cancel;
- (void)start;

@end