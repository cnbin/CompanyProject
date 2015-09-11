//
//  PingAnXiaoYuanViewController.m
//  HXXY
//
//  Created by Apple on 9/11/15.
//  Copyright (c) 2015 广东华讯网络投资有限公司. All rights reserved.
//

#import "PingAnXiaoYuanViewController.h"
#import "PingAnCell.h"
#import "PingAnModel.h"

@interface PingAnXiaoYuanViewController (){
    
    UITableView *_tableView;
    NSMutableArray *_saveDataArray;
}

@end

@implementation PingAnXiaoYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _saveDataArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
    
    _tableView.rowHeight = 30;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    //注册
    [_tableView registerNib:[UINib nibWithNibName:@"PingAnCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self GetInfo];
    [NSTimer scheduledTimerWithTimeInterval:10
                                     target:self
                                   selector:@selector(updateDataMethod:)
                                   userInfo:nil
                                    repeats:YES];

}
-(void)updateDataMethod:(NSTimer*)timer {
    
    [self GetInfo];
    
}
-(void)GetInfo{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:@"http://192.168.66.134:81/PingAnDemo/PiangAnTable.aspx" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *PinAnXiaoYuanArray = responseObject[@"result"];
        
        for (NSDictionary *dict  in PinAnXiaoYuanArray)
        {
            PingAnModel * model = [[PingAnModel alloc]init];
            
            model.StudentName = dict[@"StudentName"];
            model.GradeName = dict[@"GradeName"];
            model.ClassesName = dict[@"ClassesName"];
            model.InOut = dict[@"InOut"];
            
            NSRange range = NSMakeRange(6,13);
            NSString * DateString= [dict[@"CreateDate"] substringWithRange:range];
            
            double timevalue = [DateString doubleValue]/1000.0;
            NSString * date = [NSString stringWithFormat:@"%lf",timevalue];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
            
            NSString *dateLoca = [NSString stringWithFormat:@"%@",date];
            NSTimeInterval time= [dateLoca doubleValue];
            
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            NSString *timestr = [formatter stringFromDate:detaildate];
            model.Date = timestr;
            
            [_saveDataArray addObject:model];
            
        }
        
        //刷新表
        [_tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _saveDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PingAnCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    PingAnModel * model = _saveDataArray[indexPath.row];
    
    cell.GradeName.text = model.GradeName;
    cell.StudentName.text = model.StudentName;
    cell.ClassesName.text = model.ClassesName;
    cell.InOut.text = model.InOut;
    cell.Date.text = model.Date;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
