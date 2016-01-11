Welcome to Lexicontext

This README contains:

1. Introduction
2. Integration Information

=====================================
1. Introduction

Lexicontext is an offline dictionary component for iOS apps. It was built for developers looking to 
add an in-app dictionary to their apps.
A simple Objective-C API allows you to lookup the definition of a word and get the result in either 
plain-text or HTML.
As an illustration of the potential value of Lexicontext, consider the value provided by the dictionaries 
that ship with Kindle for iOS and Apple's iBooks app.

This archive should contain these files:
 - README.txt : This text file containing instructions. 
 - Lexicontext.h : the header file to import from your code.
 - libLexicontext.a : The library containing Lexicontext's dictionary access code. 
 - LexicontextAssets.bundle : an iOS bundle that contains the dictionary data files (WordNet).
 
Lexicontext's terms of service can be found at: http://www.lexicontext.com/terms.html
 
=====================================
2. Integration

Note: Lexicontext is compatible with iOS 5.1 and higher.
 
To integrate Lexicontext into your iOS application:

1. Extract the downloaded lexicontext zip on your Mac (if your read the file you've already done this :)

2. Open your app's XCode project and from the menu select Project->Add to Project... (or ⌥+⌘+A), browse to the folder 
   where you extracted the lexicontext zip file, select the files Lexicontext.h, libLexicontext.a and 
   LexicontextAssets.bundle and click the "Add" button. In the next dialog, make sure that the option 
   "Copy items into group's folder (if needed)" is checked and click the "Add" button. The files will be copied 
   into your XCode's project and after a few seconds they will show up in your project tree.

3. Drag the header file to your Classes Group, the bundle file to your Resources Group and the library file to your 
   Frameworks Group. This step is optional but it will help you keep your project tidy. 
 
4. In XCode's project tree, expand the "Targets" group and then expand your app target entry. In your XCode project 
   tree, drag the libLexicontext.a entry into your target's "Link Binary With Libraries" group.
   
5. In your class:
    a. Import Lexicontext => #import "Lexicontext.h"
    b. Obtain a reference to the dictionary => Lexicontext *dictionary = [Lexicontext sharedDictionary];
    c. Lookup a word => NSString *definition = [dictionary definitionFor:@"Apple"];

You're done! That's all you need to do to begin using the dictionary.

More sophisticated examples are provided at: http://www.lexicontext.com/usage.html

=====================================

Please let us know if you have any questions. If you need any help, just email ori@lexicontext.com!

Cheers,
The Lexicontext Team
http://www.lexicontext.com
ori@lexicontext.com
