# Invisible XML (ixml) Exercise 1

Let's start with [this plain text document representing data about Pokemon moves from generation 5](https://raw.githubusercontent.com/newtfire/textAnalysis-Hub/refs/heads/main/Class-Examples/invisible_xml/pokemon-moves-gen5.txt). You can follow the link to download and save this directly, or use `git pull` on the main branch of  the textAnalysis-Hub/Class-Examples/invisible_xml/pokemon-moves-gen5.txt. Save it in a folder with your personal repo / homework to work on together

The file has newlines and tab characters giving it a clear structure. The first 13 lines are meant to be column headers, but were formatted differently. The rest of the file uses tab characters to provide information about:
*  the **name** of a move 
*  the **type** of a move
*  the **category** (cat.) of a move
*  the **power** of a move (in digits) 
*  the **accuracy** (acc.) of a move (in digits)
*  the **power points** (pp) of a move (in digits)
*  the **effect** of a move.

**Consult our guide to ["Writing your First Invisible XML"](https://github.com/newtfire/textAnalysis-Hub/blob/main/Class-Examples/invisible_xml/iXMLstart.md)** as you work on this exercise. 

Your task is to create an invisible XML grammar that represents a good XML model of your choice, organizing this information into elements and/or attributes. 

## Setting up your workspace

* We suggest opening the text file in oXygen
* Open a second text file to save with the **`.ixml`** extension to write your Invisible XML grammar. 
* Make surer you can see all the different space characters (just like for Regex tasks): If this is turned off, go to your oXygen XML Editor Settings (or Options >> Preferences), choose Editor >> tick the two checkboxes for "Show TAB/NBSB/EOL/EOF marks" and "Show SPACE marks". 
* Split your windows in oXygen (as we suggest for working on CSS or Relax NG files) using **Window >> Tile Editors Vertically**.

## Guidance 

### Tiny Starter Orientation: Can you fully process just the heading?
To get started, we can just try isolating the heading into its own separate text file, just to get used to writing ixml and making sure you know how to process a grammar. (Afterwards you'll incorporate your ixml for this heading into the full XML for the whole document.)  Save this portion in its own file, and open it in oXygen so you can see the line numbers!

```
Name
	
Type
	
Cat.
	
Power
	
Acc.
	
PP
	
Effect
```
**Make sure there's NOT an extra newline after the last row for Effect,** to mimic the formatting in the larger document! (That **single newline** at the end will be significant for our separation of the heading from the rest of the document later!) 

Try to wrap this whole text in one XML root element (without worrying about distinguising inner element just yet..) Can you describe the formatting to wrap this in one element? 

The reason we're doing this is so you can test your first grammar quickly! Save your .ixml grammar file in the same folder with the text files, and open your shell, navigate to the directory where you saved your work, and run coffeepot to see if it works, using this format:

```shell
coffeepot -g:yourGrammar.ixml -i:heading.txt
```
We suggest that when you can write a grammar to represent this, and the grammar processes without ambiguity, you



