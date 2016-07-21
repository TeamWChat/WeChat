//
//  AvatarSetViewController.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AvatarSetViewController.h"

@interface AvatarSetViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,weak) UIImageView *imageView;
@end

@implementation AvatarSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [CommonUtils navBarButtonItemWithView:[UIImage imageNamed:@"更多信息"] text:nil font:0 viewWith:25 viewHeight:20 target:self action:@selector(clickRightItem)];

    [self displayAvatar];
}
-(void)clickRightItem
{
    [self createAlertViewController];
}

//图片代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
 
        //加在视图中
        self.imageView.image = image;
        
    }
}

//显示图片
-(void)displayAvatar
{
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(0, 64 , WIDTH, HEIGHT - 64);
    self.imageView.image = [CommonUtils getImageFromFileWithImageName:@"/avatar.png"] ;
}


//创建弹出视图
-(void)createAlertViewController
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相机
    UIAlertAction *camerl = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerCamera = [[UIImagePickerController alloc] init];
        pickerCamera.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:pickerCamera animated:YES completion:nil];
        
    }];
    //相册
    UIAlertAction *choose = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerChoose = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerChoose.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerChoose.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerChoose.sourceType];
        }
        pickerChoose.delegate = self;
        pickerChoose.allowsEditing = NO;
        [self presentViewController:pickerChoose animated:YES completion:nil];
    }];
    
    //保存图片
    UIAlertAction *saveImage = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CommonUtils writeImageToFile:self.imageView.image imageName:@"/avatar.png"];
    }];
    
    //取消
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:nil];
    if ([cancel valueForKey:@"titleTextColor"]) {
        [cancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    }
    [alert addAction:camerl];
    [alert addAction:choose];
    [alert addAction:saveImage];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

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
#pragma mark 
@end
