# StringToHashMap
Convert string to hashmap based a set of rules. Created in swift. Added Unit testing and UI testing.

This project was created as part of a coding exercise I received. Challenge was to convert a user input text to hashmap based on a set of rules. 

These are the rules:

Given the following filename:  polar_cat_plane_swift.txt 

Rules: 

*Filename should be entered in a text field. 
	
*The first word (polar) is a distinct identifier that should be the value of the key NAME. 
	
*All of the following items are appended on with underscores separating them and each item contains a key value pair. The key is the first character and the value is the remaining characters. There can be N number of items after the value for "NAME". 
	
*Parse this filename and return a dictionary of values, removing any file extensions but also keeping in mind that this filename could end up with incorrect characters or incorrect amounts of characters. 
	
*Save the output of parsing the filename in a file with the same name in the /Documents directory.  Also, print the output to the screen similar to the screen shots 

*************************************************************

Example input: 
polar_cat_plane_swift.txt 

Example output: 
Filename polar_cat_plane_swift.txt saved with contents: 

{ 
"NAME" : "polar", 
"c" : "at", 
"p" : "lane", 
"s": "wift" 
}; 

At path: -URL path to polar_cat_plane_swift.txt-
