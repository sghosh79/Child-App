//
//  ViewController.m
//  ChildApp
//
//  Created by shu ghosh on 4/16/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
//    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
//    [locationManager startUpdatingLocation];

}

-(void)viewWillAppear:(BOOL)animated //is thiscallback?
{
    [super viewWillAppear:YES];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
   // int minutes = decimal * 60;
  //  double seconds = decimal * 3600 - minutes * 60;
    self.latitude = [NSString stringWithFormat:@"%d", degrees];
//    latLabel.text = lat;
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
 //   minutes = decimal * 60;
   // seconds = decimal * 3600 - minutes * 60;
    self.longitude = [NSString stringWithFormat:@"%d", degrees];
  //  longLabel.text = longt;
    
   NSLog(@"Longitude is : %@",self.longitude);
    NSLog(@"Latitude is : %@",self.latitude);
    [locationManager stopUpdatingLocation];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Update:(id)sender {
    
    self.userID = self.userIDText.text;
//    self.longitude = self.longitudeText.text;
//    self.latitude = self.latitudeText.text;


//    NSDictionary *childDict =
//    @{@"utf8": @"✓",@"authenticity_token":@"EvZva3cKnzo3 Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",@"user":@{@"username":self.userID,@"current_lat":self.latitude,@"current_longitude":self.longitude}, @"commit":@"Create User",@"action":@"update",@"controller":@"users"};
    if (self.latitude == nil) {
        NSLog(@"SET A LOCATION, DUMMY");
    } else {
    NSDictionary *childDict =
  @{@"utf8": @"", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"current_lat":self.latitude,@"current_longitude":self.longitude}, @"commit":@"Create User", @"action":@"update", @"controller":@"users"};
 
        
        NSDictionary *childDict2 =
        @{@"utf8": @"", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"current_lat":@"-50",@"current_longitude":@"-50"}, @"commit":@"Create User", @"action":@"update", @"controller":@"users"};

        
        
    //label to the left of the colon and argument to the right is getting passed
    
    //datawithJSONObject - is where I put the dictionary to convert to JSON
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:childDict options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //   NSDictionary *userDetails = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        NSLog(@"json: %@", jsonString);
        

        
        //ASYNCHRONOUS PATCH
        
        NSString * urlstring = [NSString stringWithFormat:@"URL", self.userID];
        NSURL *url = [[NSURL alloc] initWithString:urlstring];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
//        [request setHTTPBody:[ dataUsingEncoding:NSUTF8StringEncoding]];
        
        // Specify that it will be a PATCH request
        request.HTTPMethod = @"PATCH";
        request.HTTPBody = jsonData;
        
        // This is how we set header fields
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        // Convert your data and set your request's HTTPBody property
    
        
        // Create url connection and fire request
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [conn start];
    }
  }
    
}




@end
