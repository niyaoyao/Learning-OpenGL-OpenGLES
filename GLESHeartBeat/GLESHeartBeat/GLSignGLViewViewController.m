//
//  GLSignGLViewViewController.m
//  GLESHeartBeat
//
//  Created by ibu_mob_basic_9 on 2024/1/26.
//

#import "GLSignGLViewViewController.h"
#import <OpenGLES/ES3/gl.h>
#import <GLKit/GLKit.h>
#import "NYGLShader.h"
#import "NYGLHelper.h"

@interface GLSignGLViewViewController () <GLKViewDelegate>

@property (nonatomic, strong) GLKView *glView;
@property (nonatomic, strong) NYGLShader *shader;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSThread *thread;

@end

@implementation GLSignGLViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.glView];
    [self addCADisplayLink];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.glView.frame = self.view.frame;
}

- (void)addCADisplayLink {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshGLView)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.displayLink.preferredFramesPerSecond = 60;
}

- (void)refreshGLView {
    [self.glView display];
}

- (void)startTimerThread {
    NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(setupTimerThread) object:nil];
    [thread start];
    self.thread = thread;
}

- (void)setupTimerThread {
    @autoreleasepool {
        NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
        [self addCADisplayLink];
        [runLoop run];
    }
  
}


- (void)glkView:(nonnull GLKView *)view drawInRect:(CGRect)rect {
    float colors[] = {
        1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f, 1.0, 0.f, 0.f,1.f,
    };
    
    const int numPoints = 400;
    float verticesX[numPoints] = {};
    float verticesY[numPoints] = {};

    for (int i = 0; i < numPoints; i++)
    {
        /*
           Graph function:
           (x^2 + y^2 - 1)^3 - x^2*y^3 = 0
           => y^2 - y*cbrt(x^2) + x^2 - 1 = 0
           */
        float x = (float)(i);
        x = 2 * x / (numPoints - 1) - 1;
        float delta = cbrt(x*x) * cbrt(x*x) - 4*x*x + 4;
        float y1 = 0.0;
        if (x < 0 && x >= -1) {
            y1 = sqrt(0.25 - (x + 0.5) * (x + 0.5));
        } else {
            y1 = sqrt(0.25 - (x - 0.5) * (x - 0.5));
        }
        y1 += 0.8;
//        float y1 = (cbrt(x*x) + sqrt(delta)) / 2;
        float y2 = (cbrt(x*x) - sqrt(delta)) / 2;
        if (i%2==0) {
            [NYGLHelper beatX:&x y:&y1];
        } else {
            [NYGLHelper beatX:&x y:&y2];
        }
        verticesX[i] = x;
        verticesY[i] = i % 2 == 0 ? y1 - 0.575 : y2;
//        NSLog(@"%.2f,%.2f,%.2f,%.2f,", x, y1, y2, delta);
    }
    unsigned int VBO_vertext, VBO_vertext2, VBO_color, VAO, EBO;
    // bind the Vertex Array Object first, then bind and set vertex buffer(s), and then configure vertex attributes(s).
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);

    glGenBuffers(1, &VBO_vertext);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_vertext);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesX), verticesX, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 1, GL_FLOAT, GL_FALSE, 1 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);

    glGenBuffers(1, &VBO_vertext2);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_vertext2);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesY), verticesY, GL_STATIC_DRAW);
    glVertexAttribPointer(1, 1, GL_FLOAT, GL_FALSE, 1 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(1);


    glGenBuffers(1, &VBO_color);
    glBindBuffer(GL_ARRAY_BUFFER, VBO_color);
    glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_STATIC_DRAW);
    glVertexAttribPointer(2, 4, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(2);

    // note that this is allowed, the call to glVertexAttribPointer registered VBO as the vertex attribute's bound vertex buffer object so afterwards we can safely unbind
    glBindBuffer(GL_ARRAY_BUFFER, 0);

    // remember: do NOT unbind the EBO while a VAO is active as the bound element buffer object IS stored in the VAO; keep the EBO bound.
    //glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

    // You can unbind the VAO afterwards so other VAO calls won't accidentally modify this VAO, but this rarely happens. Modifying other
    // VAOs requires a call to glBindVertexArray anyways so we generally don't unbind VAOs (nor VBOs) when it's not directly necessary.
    glBindVertexArray(0);
    // Drawing code here.
    CGFloat w = rect.size.width;
    CGFloat x = w;
    CGFloat h = w;
    CGFloat y = rect.size.height * 1.5;
    glViewport(x, y, w, h);
    glClearColor(0.f, 0.f, 0.f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // draw our first triangle
    glUseProgram(self.shader.shaderProgram);
    glBindVertexArray(VAO);
    glDrawArrays(GL_LINE_STRIP, 0, numPoints);
    glLineWidth(3);
    glBindVertexArray(0);
}

- (GLKView *)glView {
    if (!_glView) {
        GLKView *glView = [[GLKView alloc] initWithFrame:CGRectZero context:[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3]];
        glView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
        glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        glView.drawableStencilFormat = GLKViewDrawableStencilFormat8;
        glView.drawableMultisample = GLKViewDrawableMultisample4X;
        glView.delegate = self;
        [EAGLContext setCurrentContext:glView.context];
        _glView = glView;
        _glView.backgroundColor = UIColor.clearColor;
    }
    return _glView;
}

- (NYGLShader *)shader {
    if (!_shader) {
        _shader = [[NYGLShader alloc] init];
        [_shader loadVertexShaderFileName:@"VertexShader" extension:@"glsl"];
        [_shader loadFragmentShaderFileName:@"FragmentShader" extension:@"glsl"];
        [_shader linkShaderProgram];
    }
    return _shader;
}


@end
