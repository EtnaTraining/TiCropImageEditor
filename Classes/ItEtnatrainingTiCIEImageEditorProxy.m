/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ItEtnatrainingTiCIEImageEditorProxy.h"
#import "TiApp.h"

@implementation ItEtnatrainingTiCIEImageEditorProxy

-(void)_destroy
{
	[super _destroy];
}

- (void)open:(id)args
{
    id blob = [args objectAtIndex:0];
    id animationProperties = [args objectAtIndex:1];
    
    UIModalPresentationStyle *modalStyle = nil;
    BOOL animated = YES;

    ENSURE_UI_THREAD(open,args);
	ENSURE_TYPE([args objectAtIndex:0],TiBlob);
    ENSURE_TYPE_OR_NIL(animationProperties, NSDictionary);
    
    UIImage* image = [(TiBlob*)blob image];
    
    PECropViewController *controller = [[PECropViewController alloc] init];
    [controller setDelegate:self];
    [controller setImage:image];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (animationProperties != nil) {
        modalStyle = [TiUtils intValue:@"modalStyle" properties:animationProperties def:UIModalPresentationNone];
        animated = [TiUtils boolValue:@"animated" properties:animationProperties def:YES];
    }
    
    [navigationController setModalPresentationStyle:modalStyle];
    [[TiApp app] showModalController:navigationController animated:animated];
}


- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (croppedImage != nil) {
        TiBlob *blob = [[TiBlob alloc] initWithImage:croppedImage];
        NSDictionary *event = @{@"image" : blob};
        
        [self fireEvent:@"done" withObject:event];
    }
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
