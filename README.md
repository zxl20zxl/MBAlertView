 MBAlertView
===================

MBAlertView is a fast block-based alert and HUD library with a dead simple API. 

As seen in [Noteclub.](https://itunes.apple.com/us/app/noteclub/id647643196?mt=8) Download it won't you?

###MBAlertView now comes in two styles. 

####Flat

[![](http://i.imgur.com/oKrzrY1.png)](http://i.imgur.com/oKrzrY1.png)

####Classic

[![](http://i.imgur.com/3s3eJ.png)](http://i.imgur.com/3s3eJ.png)
[![](http://i.imgur.com/7CbbT.png)](http://i.imgur.com/7CbbT.png) 
[![](http://i.imgur.com/lq53u.png)](http://i.imgur.com/lq53u.png)
[![](http://i.imgur.com/Aqfnr.png)](http://i.imgur.com/Aqfnr.png)

### Features
<ul>
	<li>Nested alerts and HUDs</li>
	<li>Block based</li>
	<li>Images</li>
	<li>Nice animations</li>
	<li>Doesn't use any PNG files. Everything is drawn with code.</li>
</ul>

##Installation

After cloning, run

`git submodule init`

`git submodule update`


## Usage

There are two factory methods to get you started:

### Alerts

There are now two alert styles, Classic and Flat. Flat is the iOS 7 style.

To create a flat alert:

``` objective-c
MBFlatAlertView *alert = [MBFlatAlertView alertWithTitle:@"Special Instructions" detailText:@"Are you sure?" cancelTitle:@"Cancel" cancelBlock:nil];
[alert addButtonWithTitle:@"Hello" type:MBFlatAlertButtonTypeBold action:^{}];
[alert addToDisplayQueue];
```

#####Note: MBFlatAlertView is auto-layout based.

To create a classic alert:

``` objective-c
MBAlertView *alert = [MBAlertView alertWithBody:@"Are you sure you want to delete this note? You cannot undo this." cancelTitle:@"Cancel" cancelBlock:nil];
[alert addButtonWithText:@"Delete" type:MBAlertViewItemTypeDestructive block:^{}];
[alert addToDisplayQueue];
```

### HUDs
``` objective-c
[MBHUDView hudWithBody:@"Wait." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:4.0 show:YES];
```

You can see more in the easy to follow demo. (That's currently broken)

##Other
Follow me on Twitter so that I feel like I'm doing something with my life.

[Bitar](http://www.bitar.io/paragraphs/) [@bitario](https://twitter.com/bitario)

## License
MBAlertView is available under the MIT license. (Whatever the hell that means)
