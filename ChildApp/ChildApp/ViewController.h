//
//  ViewController.h
//  ChildApp
//
//  Created by shu ghosh on 4/16/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate > {
    CLLocationManager *locationManager;
//    IBOutlet UILabel *latLabel;
//    IBOutlet UILabel *longLabel;
}


@property NSString *userID;
@property NSString *latitude;
@property NSString *longitude;
//@property NSString *radius;

@property (weak, nonatomic) IBOutlet UITextField *userIDText;


- (IBAction)Update:(id)sender;


@end
