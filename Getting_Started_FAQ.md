## Papervision3D ##

### What is Papervision3D? ###
Papervision3D is an open source 3D engine for the Flash platform.

### Who are the developers? ###
Papervision3D is written and maintained by a small [core team](Papervision3D_Core_Team.md), and contributed to by its ever-growing community.

### When will it be released? ###
Papervision3D entered Public Beta on July 7th, 2007.

## Getting started ##

### How can I download Papervision3D? ###
You can download the latest revision from the [SVN repository](Download_from_SVN.md).

### Getting Started Walkthrough ###
(this part should be later moved to a new page)

  1. Download and install a SVN client. On this case, tortoise for windows ( http://tortoisesvn.tigris.org/ ) . Then create an empty folder, right click on it and choose "SVN checkout"
  1. Paste this address on the URL box and press OK
  1. `http://papervision3d.googlecode.com/svn/trunk/`
  1. Finish download. Now it's time to set up Papervision3D.
  1. Open Flash CS3 and click Edit>Preferences>Actionscript and click the button "Actionscript 3.0 settings"
  1. On the box named "class path", click the plus sign and then the (sniper like) target icon
  1. Navigate to the folder you downloaded Papervision3D files and then to as3/trunk/src
  1. Click OK and open a new or existing Flash file. Be sure there is nothing selected and click the property panel
  1. In this example we will be building a simple plane rotating, but feel free to choose other examples from the [examples page](http://wiki.papervision3d.org/index.php?title=Examples). On the box named "document class" write "ExampleTransformationRotate" (no quotes, no ".as" extension)
  1. Save the document somewhere you can find, but outside any of the Papervision3D folders.
  1. reate a new file, choose "Actionscript file" instead of "Flash file". Name it ExampleTransformationRotate.as (note the extension .as ) and save it on the same folder as your Flash file.
  1. Go back to the Flash file. Now clicking on the pencil, on the property panel beside "document class" should take you to the new .as file you just  created.
  1. Paste [this code](http://www.andrestubbe.com/downloads/papervision3d/ExampleTransformationRotate.as) on the Actionscript file, save it, and test the movie.
  1. It should be working! If not refer to the forums, if it does, try other examples and good luck.

### How do I install the classes? ###

Papervision's files are in what is called a subversion server, for easier managing of the files by the developers. So first get a SVN client. See more at [[from SVN](Download.md)] . Now point to
> http://papervision3d.googlecode.com/svn/trunk/
and find the folder called papervision3d where you will find Papervision3D.as and many other folders. Download that one

Now put this somewhere in your computer that you will keep most of your files.

You might notice that there are no downloadable .fla files from anywhere. That's because to help the workflow of the community most actions are better kept in outside linkable files (the .AS ) and then linked from the documents. Now you have to set up Flash to recognize those files and import them as "classes" for the documents. There are many ways to do it. You also might want to update your Flash Player and upgrade your Flash application to be sure it supports everything said down here: -

**Inside one's document: If you are using Flash 9, just add one of the main as files as the "document class", in the "properties" pane where you can set the document size. The files will have to be somewhere Flash can find it. It's quite tricky to write those by hand as there is no browse.**Inside its publish settings: publish settings> flash> actionscript> settings
**as a global thing on preferences> actionscript> Actionscript 2/3 settings**

That's something tricky to do. And not very easy.

### How do I use the downloaded files? What's the problem with Flash? ###

Next you may want to download some examples from this wiki or somewhere in order to start playing with them. You will notice there are <i>.as</i> files as well as <i>.fla</i> files. With those you can use the aforementioned methods in order to link them both, or maybe just copy the source code on frame 1 of your movie. We are not sure which may or may not work. Finally you will have to edit the movie actions in order to make them call the actions. Otherwise all you have is just a blank file with some classes. Good luck with that...

### Which flavour of ActionScript should I use with Papervision3D, and does it support AS1 and AS2? ###


This is often flash player dependent:

1 - Flash player 9 upwards - use AS3 Papervision3D engine.

2 - Flash player 8         - use AS2 Papervision3D engine.


If possible you should try to use the AS3 version of Papervision3D because:

1 - For anything complex you will need the faster processing of AS3 and flash player 9.

2 - The code base for the AS3 version is more advanced and more stable.

3 - More development work is currently being done using the AS3 version. More people are experimenting with it as well.


When should I use AS2?

1 - For some commercial projects where the player is limited Flash 8.

2 - If you do not have Flash CS3 and are not able to compile using other tools. ([Flex 2](http://www.adobe.com/products/flex/))


Can I use AS1, Flash Lite, or SwishMax with Papervision3D?

1 - Yes you can use AS1 to control the AS2 Papervision3D engine from the timeline, but you may need to write some AS2 code.

2 - Papervision3D uses the Flash BitmapData class the minimum player version it supports is Flash 8, for this reason there is no support for Flash Lite 1 and probably not Flash Lite 2.

3 - Papervision3D does not support pure AS1, since the engine is only available in AS2 and there are no plans to provide a pure AS1 version.

4 - Papervision3D does not support SwishMax code, the only current way to control the engine would be to create a Flash movie with Flash, and the Papervison3D as2 classes and then load in a SwishMax controller movie at run time.

## License ##

### Is Papervision3D an open source project? ###
Yes.

### What type of license is it distributed under? ###
Papervision3D is distributed under the [MIT](http://www.opensource.org/licenses/mit-license.php) license.

### Can I use Papervision3D in my own commercial projects? ###
Yes, you can.

## Mailing List ##

### Can I join the Papervision3D mailing list? ###
You can subscribe to the [Papervision3D mailing list](http://osflash.org/mailman/listinfo/Papervision3D_osflash.org). You will receive further instructions in the welcome email.

### Is there an archive of the mailing list? ###
Yes, the [Papervision3D archives](http://osflash.org/pipermail/papervision3d_osflash.org) are sorted by months and categorized by thread, subject, author and date.

### How can I unsubscribe to the mailing list? ###
Please refer to the [Papervision3D mailing list](http://osflash.org/mailman/listinfo/Papervision3D_osflash.org).

## Contributing ##

### How can I make contributions to the engine? ###
If you've written your own extensions to the engine, just send them by mail or post them in the mailing list. We will have a look at them and consider including them in the SDK of the engine.

We are currently setting up a scheme for contributors to enable developers on several levels to contribute in one form, or another.