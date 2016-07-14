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

    [CommonUtils navRightBarButtonItemWithView:[UIImage imageNamed:@"更多信息"] text:nil font:0 viewWith:30 viewHeight:20 target:self action:@selector(clickRightItem)];
    [self displayAvatar];
}
-(void)clickRightItem
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camerl = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerCamera = [[UIImagePickerController alloc] init];
        pickerCamera.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:pickerCamera animated:YES completion:nil];
        
    }];
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
    UIAlertAction *saveImage = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CommonUtils writeImageToDB:self.imageView.image];
    }];


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

//图片代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
/*
        NSData *data;
        if (UIImagePNGRepresentation(image) ==nil)
        {
            data = UIImageJPEGRepresentation(image,1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }

        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/userHeader.png"] contents:data attributes:nil];
*/
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
 
        //加在视图中
        self.imageView.image = image;
        
    }
}


-(void)displayAvatar
{
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(0, 64 , WIDTH, HEIGHT - 64 - 49);
    self.imageView.image =[UIImage imageWithData:[self getImageFromDB]] ;
}

-(NSData *)getImageFromDB
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"pic.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM t_pic"];
        FMResultSet *rs = [db executeQuery:sqlStr];

        NSData *imageData;
        while ([rs next]) {
            imageData = [rs dataForColumn:@"photo"];
        }
        return imageData;
    }
    
    return nil;
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
