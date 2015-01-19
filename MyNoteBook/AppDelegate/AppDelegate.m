//
//  AppDelegate.m
//  MyNoteBook
//
//  Created by TaoZeyu on 15/1/13.
//  Copyright (c) 2015年 TaoZeyu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppMacro.h"

#import "Group.h"
#import "Note.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if([Group insertDefaultGroupIfFirstLaunch: self]) {
        [self insertInitNotes:[Group getDefaultGroup:[self managedObjectContext]]];
    }
    return YES;
}

-(void) insertInitNotes:(Group *)group
{
    NSArray* noteInfoArray = @[
            @"欢迎使用 MyNoteBook",
            @"这是一个演示 DEMO，你可以添加，编辑，删除笔记，并将它们分组。\n\n小提示：如果你想删除某条笔记或分组，长按它即可。",
            
            @"计划",
            @"1 给猫买猫粮。\n\n2 交物业费。\n\n3 报销交通费。",
            
            @"秦朝 － 维基百科",
            @"\n秦朝（前221年－前207年），是中国历史上首次在中国本土建立大一统帝国的中国朝代。秦国君王嬴政从西元前230年至前221年发动灭六国的战争，结束中国战国时期、建立秦朝。秦朝源自周朝诸侯国秦国。\n\n前770年，秦族秦襄公在东周周平王东迁时有功，受封于关中平原，建立秦国。秦国于战国时期逐渐转强，到秦国君王嬴政灭六国，建立秦朝。由于皇室姓嬴，所以史书又称“嬴秦”。秦王政建立秦朝后自称“始皇帝”（史称秦始皇），从此中国有了皇帝的称号。\n\n秦二世继位后秦廷被宦官赵高掌控而混乱不堪，最后爆发秦末民变，六国复国。虽然秦将章邯努力平乱，但于巨鹿之战被楚将项羽击败，秦军最后投降。前207年十月，新任秦王子婴于咸阳向楚将刘邦投降，秦朝灭亡。秦朝灭亡至西汉统一全国之期间称秦汉之际，又称西楚时期。\n\n西楚霸王项羽重建封国制体系，分封十八诸侯。由于刘邦、田荣等诸侯认为项羽分封不公而爆发叛乱，演变成楚汉战争。前202年刘邦击灭项羽，受诸侯拥戴为汉帝，建国西汉，开启汉朝，天下再归一统。",
            
            @"傅立叶变换",
            @"在阿贝尔群上的统一描述以上各种傅里叶变换可以被更统一的表述成任意局部紧致的阿贝尔群上的傅里叶变换。这一问题属于调和分析的范畴。\n\n在调和分析中，一个变换从一个群变换到它的对偶群（dual group）。\n\n此外，将傅里叶变换与卷积相联系的卷积定理在调和分析中也有类似的结论。傅里叶变换的广义理论基础参见庞特里亚金对偶性（Pontryagin duality）中的介绍。",
            
            @"得墨忒耳定律",
            @"得墨忒耳定律（Law of Demeter，缩写LoD）亦称为“最少知识原则（Principle of Least Knowledge）”，是一种软件开发的设计指导原则，特别是面向对象的程序设计。得墨忒耳定律是松耦合的一种具体案例。该原则是美国东北大学在1987年末在发明的，可以简单地以下面任一种方式总结:\n\n每个单元对于其他的单元只能拥有有限的知识：只是与当前单元紧密联系的单元；\n\n每个单元只能和它的朋友交谈：不能和陌生单元交谈；\n只和自己直接的朋友交谈。\n这个原理的名称来源于希腊神话中的农业女神，孤独的得墨忒耳。\n\n很多面向对象程序设计语言用\".\"表示对象的域的解析算符，因此得墨忒耳定律可以简单地陈述为“只使用一个.算符”。因此，a.b.Method()违反了此定律，而a.Method()不违反此定律。一个简单例子是，人可以命令一条狗行走（walk），但是不应该直接指挥狗的腿行走，应该由狗去指挥控制它的腿如何行走。",
    ];
    
    for(NSInteger i=noteInfoArray.count/2 - 1; i>=0; --i) {
        NSString *title = noteInfoArray[2*i];
        NSString *content = noteInfoArray[2*i + 1];
        
        Note* note = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Note"
                                      inManagedObjectContext:[self managedObjectContext]];
        
        [note valuesInitWithTitle:title withContent:content withGroup:group];
    }
    NSError *error;
    BOOL success = [[self managedObjectContext] save:&error];
    
    if(!success) {
        NSLog(@"save context error: %@", error.description);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "taozeyu.com.MyNoteBook" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyNoteBook" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyNoteBook.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
