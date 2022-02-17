//
//  ScanViewController.m
//  dysx
//
//  Created by chengbo on 2022/2/17.
//

#import "ScanViewController.h"

@import AVFoundation;

@interface ScanViewController () <AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UILabel * introLab;
    BOOL isLightOn;
//    UIButton *mineQRCode;
//    UIButton *theLightBtn;
    BOOL hasTheVC;
    BOOL isFirst;
    BOOL upOrdown;
    int num;
//    AVCaptureVideoPreviewLayer *preView;
//    AVCaptureDevice *captureDevice;
    NSTimer * timer;
}

@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) UIImageView *lineIV;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) UIButton *mineQRCode;
@property (nonatomic, strong) UIButton *theLightBtn;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self setupDevice];
}

- (void)initUI {
    isFirst = YES;
    upOrdown = NO;
    num = 0;
}

- (void)startSessionRightNow:(NSNotification*)notification {
    [self creatTimer];
    [_session startRunning];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(isFirst)
    {
        [self creatTimer];
        [_session startRunning];
    }
    isFirst=NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self deleteTimer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"startSession" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


#pragma mark - 删除timer
- (void)deleteTimer
{
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
}
#pragma mark - 创建timer
- (void)creatTimer
{
    if (!timer) {
        timer=[NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(startSessionRightNow:) name:@"startSession" object:nil];
    if (!isFirst) {
        [self creatTimer];
        [_session startRunning];
    }
}

- (void)setupDevice {
    //1.初始化捕捉设备AVCaptureDevice，类型为AVMediaTypeVideo
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    //用captureDevice创建输入流input;
    NSError *error;
    AVCaptureInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    //创建会话
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    //预览视图
    AVCaptureVideoPreviewLayer *preview = [[AVCaptureVideoPreviewLayer alloc] init];
    //设置预览图层填充方式
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [preview setFrame:self.view.layer.bounds];
    [self.view.layer addSublayer:preview];
    //输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    self.output = output;
    //设置扫描范围
    output.rectOfInterest = LRect(0.25, (SCREEN_WIDTH - self.view.layer.bounds.size.width * 0.7)/2/self.view.layer.bounds.size.width, self.view.layer.bounds.size.width * 0.7/self.view.layer.bounds.size.height, (self.view.layer.bounds.size.width * 0.7)/self.view.layer.bounds.size.width);
    NSArray *typesArr = output.availableMetadataObjectTypes;
    if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    } else {
        [_session stopRunning];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"抱歉" message:@"相机权限被拒绝，请前往设置-隐私-相机启用此应用的相机权限。" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *setupAlertAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAlertAction];
        [alertController addAction:setupAlertAction];
        alertController.preferredAction = setupAlertAction;
        return;
    }
    UIView *drawView = [[UIView alloc] initWithFrame:self.view.bounds];
    drawView.backgroundColor = [UIColor blackColor];
    drawView.alpha = 0.5f;
    [self.view addSubview:drawView];
    //选定一块区域，设置不同的透明度
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:LRect(0, 0, self.view.width, self.view.height)];
    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:LRect((SCREEN_WIDTH - self.view.layer.bounds.size.width * 0.7)/2, self.view.layer.bounds.size.height * 0.25, self.view.layer.bounds.size.width * 0.7, self.view.layer.bounds.size.height * 0.7) cornerRadius:0]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [drawView.layer setMask:shapeLayer];
    UIImageView *codeFrameImgView = [[UIImageView alloc] initWithFrame:LRect((SCREEN_WIDTH - self.view.layer.bounds.size.width * 0.7)/2, self.view.layer.bounds.size.height * 0.25, self.view.layer.bounds.size.width * 0.7, self.view.layer.bounds.size.width * 0.7)];
    codeFrameImgView.contentMode = UIViewContentModeScaleAspectFit;
    [codeFrameImgView setImage:[UIImage imageNamed:@"codeframe"]];
    [self.view addSubview:codeFrameImgView];
    introLab = [[UILabel alloc] initWithFrame:LRect(_preview.frame.origin.x, _preview.frame.origin.y + _preview.frame.size.height, _preview.frame.size.width, 40.f)];
    introLab.numberOfLines = 1;
    introLab.textAlignment = NSTextAlignmentCenter;
    introLab.textColor = [UIColor whiteColor];
    introLab.adjustsFontSizeToFitWidth = YES;
    introLab.text = @"将二维码放入框内，即可自动扫描";
    [self.view addSubview:introLab];
    _mineQRCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _mineQRCode.frame = LRect(self.view.width / 2 - 100 / 2.0, introLab.y + introLab.height - 5.f, 100.f, introLab.height);
    [_mineQRCode setTitle:@"我的二维码" forState:UIControlStateNormal];
    [_mineQRCode setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_mineQRCode addTarget:self action:@selector(mineQRCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mineQRCode];
    _mineQRCode.hidden = YES;
    
    //theLightBtn
    _theLightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _theLightBtn.frame = CGRectMake(self.view.frame.size.width / 2 - 100 / 2, _mineQRCode.frame.origin.y + _mineQRCode.frame.size.height + 20, 100, introLab.frame.size.height);
    
    [_theLightBtn setImage:[UIImage imageNamed:@"light"] forState:UIControlStateNormal];
    [_theLightBtn setImage:[UIImage imageNamed:@"lighton"] forState:UIControlStateSelected];
    [_theLightBtn addTarget:self action:@selector(lightOnOrOff:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_theLightBtn];
    
    if (![_captureDevice isTorchAvailable]) {
        _theLightBtn.hidden = YES;
    }
    
    // Start
    _lineIV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - self.view.layer.bounds.size.width * 0.7)/2,self.view.layer.bounds.size.height * 0.25 , self.view.layer.bounds.size.width * 0.7, 5)];
    //NSString *lineName = [@"Resource.bundle" stringByAppendingPathComponent:@"line"];
    
    _lineIV.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:_lineIV];
    
    //开始扫描
    [_session startRunning];
    
}


- (void)lightOnOrOff:(UIButton *)sender {
    sender.selected = !sender.selected;
    isLightOn = 1 - isLightOn;
    if (isLightOn) {
        [self turnOnLed:YES];
    }
    else {
        [self turnOffLed:YES];
    }
}


//打开手电筒
- (void) turnOnLed:(bool)update {
    [_captureDevice lockForConfiguration:nil];
    [_captureDevice setTorchMode:AVCaptureTorchModeOn];
    [_captureDevice unlockForConfiguration];
}
//关闭手电筒
- (void) turnOffLed:(bool)update {
    [_captureDevice lockForConfiguration:nil];
    [_captureDevice setTorchMode: AVCaptureTorchModeOff];
    [_captureDevice unlockForConfiguration];
}

- (void)showTheQRCodeOfMine:(UIButton *)sender {
    NSLog(@"showTheQRCodeOfMine");
}


- (void)animation {
    
    if (upOrdown == NO) {
        num ++;
        _lineIV.frame = CGRectMake((SCREEN_WIDTH - self.view.layer.bounds.size.width * 0.7)/2,self.view.layer.bounds.size.height * 0.25+ 2 * num, self.view.layer.bounds.size.width * 0.7, 5);
        
        if (2 * num == (int)(self.view.frame.size.width*.7)) {
            upOrdown = YES;
        }if (2 * num == (int)(self.view.layer.bounds.size.width *.7)-1){
            
            upOrdown = YES;
            
        }
        /*
        if (IS_IPHONE5||IS_IPHONE4) {
            NSLog(@"%f",(int)self.view.frame.size.width*.7);
            if (2 * num == (int)(self.view.layer.bounds.size.width *.7)) {
                upOrdown = YES;
            }else if (2 * num == (int)(self.view.layer.bounds.size.width *.7)-1){
                
                upOrdown = YES;
                
            }
        }
        else {
            
            NSLog(@"%f",(int)self.view.frame.size.width*.7-3);
            NSLog(@"%d",2 * num);
            if (2 * num == (int)(self.view.frame.size.width*.7)) {
                upOrdown = YES;
            }if (2 * num == (int)(self.view.layer.bounds.size.width *.7)-1){
                
                upOrdown = YES;
                
            }
            
        }
         */
    } else {
        num --;
        _lineIV.frame = CGRectMake((SCREEN_WIDTH - self.view.layer.bounds.size.width * 0.7)/2, self.view.layer.bounds.size.height * 0.25 + 2 * num, self.view.layer.bounds.size.width * 0.7, 5);
        
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            NSLog(@"stringValue = %@",metadataObj.stringValue);
            [self checkQRcode:metadataObj.stringValue];
        }
    }
    [_session stopRunning];
    [self performSelector:@selector(startReading) withObject:nil afterDelay:0.5];
}

-(void)startReading{
    [_session startRunning];
}
-(void)stopReading{
    [_session stopRunning];
}
/**
 * 判断二维码
 */
- (void)checkQRcode:(NSString *)str{
    
    if (str.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"找不到二维码" message:@"导入的图片里并没有找到二维码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if ([str hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        
        [_session stopRunning];
        
        [self KeepoutView:str];
        //弹出一个view显示二维码内容
        NSLog(@"%@",str);
    }
    
}
/**
 * 将二维码图片转化为字符
 */
- (NSString *)stringFromFileImage:(UIImage *)img{
    int exifOrientation;
    switch (img.imageOrientation) {
        case UIImageOrientationUp:
            exifOrientation = 1;
            break;
        case UIImageOrientationDown:
            exifOrientation = 3;
            break;
        case UIImageOrientationLeft:
            exifOrientation = 8;
            break;
        case UIImageOrientationRight:
            exifOrientation = 6;
            break;
        case UIImageOrientationUpMirrored:
            exifOrientation = 2;
            break;
        case UIImageOrientationDownMirrored:
            exifOrientation = 4;
            break;
        case UIImageOrientationLeftMirrored:
            exifOrientation = 5;
            break;
        case UIImageOrientationRightMirrored:
            exifOrientation = 7;
            break;
        default:
            break;
    }
    
    NSDictionary *detectorOptions = @{ CIDetectorAccuracy : CIDetectorAccuracyHigh }; // TODO: read doc for more tuneups
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:detectorOptions];
    
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:img.CGImage]];
    
    CIQRCodeFeature * qrStr  = (CIQRCodeFeature *)features.firstObject;
    //只返回第一个扫描到的二维码
    return qrStr.messageString;
}

- (void)KeepoutView:(NSString*)orcodeStr{
    //做扫描成功之后的逻辑处理
    UIView *outView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    outView.backgroundColor = [UIColor whiteColor];
    UIWindow *wind = [UIApplication sharedApplication].keyWindow;
    [self.view addSubview:outView];
    
}

-(void)dealloc{
    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
}



- (void)mineQRCodeAction {
    
}



@end
