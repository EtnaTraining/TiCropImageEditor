/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ItEtnatrainingTiCIEImageEditorProxy.h"
#import "TiApp.h"
#import "PECropViewController.h"

@implementation ItEtnatrainingTiCIEImageEditorProxy



-(void)_destroy
{
	[super _destroy];
}





- (void)open:(id)args
{
    ENSURE_UI_THREAD(open,args);
    
    id blob = [args objectAtIndex:0];
	ENSURE_TYPE(blob,TiBlob);
    UIImage* image = [(TiBlob*)blob image];
    
    //NSLog(@"ha chiamato la open");
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    //NSLog(@"ho instanziato il controller e assegnato il delegato");
    
    //NSString *path = @"modules/it.etnatraining.TiCIE/demo.jpg";
    //NSURL *url = [TiUtils toURL:path proxy:self];
    //UIImage *aImage = [TiUtils image:url proxy:self];
    
    
    
    //NSString *path = [NSString stringWithFormat:@"%@/modules/it.etnatraining.ticie/demo.jpg",
    //                  [[NSBundle mainBundle] resourcePath]
    //                  ];
    
    
    //UIImage* aImage = [[UIImage alloc] initWithContentsOfFile:path];
    
    
    
    //UIImage *aImage = [UIImage imageNamed:@"demo.jpg"];
    controller.image = image;
    //NSLog(@"ho caricato pure una immagine: %@", path);
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    
    [[TiApp app] showModalController:navigationController animated:YES];
}


- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    
    if (croppedImage != nil)
    {
        
        TiBlob *blob = [[TiBlob alloc] initWithImage:croppedImage];
        NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:blob,@"image",
                               nil];
        [self fireEvent:@"done" withObject:event];
        
        
        /*
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSTimeInterval  now = [[NSDate date] timeIntervalSince1970];
        NSString *filename = [NSString stringWithFormat:@"crop_%f.png", now];
        NSLog(@"Cropped file saved as %@", filename);
        
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          filename ];
        NSData* data = UIImagePNGRepresentation(croppedImage);
        [data writeToFile:path atomically:YES];
        
        
       
        
        if ([self _hasListeners:@"done"])
        {
            NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:filename,@"filename",
                                                                     nil];
            [self fireEvent:@"done" withObject:event];
        } */
        
        
        
    }
    
    
    //self.imageView.image = croppedImage;
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


@end
