YBAsyncUtils
===================

**YBAsyncUtils** is swift / Objective-C library that simplifies threading in iOS apps. It containes the follwing classes:

- **YBDispatchUtils**: contains static functions for using CGD (Grand Central Dispatch). GCD is very verbose and confusing. This class aims to reduce code and makes using GCD more clear.

## How To Get Started
###Swift
Just copy the folder YBAsyncUtils to your source folder.

###Objecive-C
-Copy the folder YBAsyncUtils to your source folder.
-Do not accept the swift briging header if prompted
-Add the swift import in .m files that use this library 
```objective-c
#import "Product Module Name-Swift.h"
```
You can verify the header name in you project **Build Settings** by looking at the values of the entries   *Product Module Name* and *Objective-C Generated Interface Header Name*

## Examples
### YBDispatchUtils

```objective-c
[YBDispatchUtils runAsync:^{
	NSLog(@"start 1");
	sleep(1);
	NSLog(@"end 1");
}];
    
[YBDispatchUtils runAsync:^{
	NSLog(@"start 2");
	sleep(1);
	NSLog(@"end 2");
} uiCompletionBlock:^{
	NSLog(@"i am on ui thread 2");
}];

    
[YBDispatchUtils runAsync:^{
	NSLog(@"start 3");
	sleep(1);
	NSLog(@"end 3");
	[YBDispatchUtils runOnUIAsync:^{
		NSLog(@"i am on ui thread 3");
	}];
	NSLog(@"Done 3");
}];

```

```swift

YBDispatchUtils.runAsync(asyncBlock: {
	print("start 1")
	sleep(1)
	print("end 1")
})

loadingIndocator.startAnimating()
YBDispatchUtils.runAsync({ () -> Void in
	print("start 2")
	sleep(1)
	print("end 2")
	}, uiCompletionBlock: { () -> Void in
		self.loadingIndocator.stopAnimating()
		print("done 2")
 })

```

