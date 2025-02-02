# Invisible XML / XProc 

We need help with developing and fine-tuning installation/configuration instructions:
<http://dh.obdurodon.org/ixml-and-xproc-configuration.xhtml> 

This is related to a tutorial under development at <http://dh.obdurodon.org/ixml-and-xproc-lesson-plan.xhtml> 
**********
# MAC OS notes 

# Preliminaries

## First, make sure you have developer (jdk) java installed:
* Check version of java in terminal with `java -version`
     * Dr. B's version is java 19, so upgrading
     * Installing latest openjdk on Mac with homebrew: <https://ansidev.xyz/posts/2023-07-11-how-to-install-openjdk-on-macos>
     * **(Need instructions for Mac students to install Homebrew and set up sudo use for the first time)**
     * **Note** if uninstalling Oracle Java, follow these instructions: <https://www.java.com/en/download/help/mac_uninstall_java.html>

# XProc Processors
## Calabash
* Installing Calabash:
    * Get it from here: https://github.com/xmlcalabash/xmlcalabash3/releases/tag/3.0.0-alpha17 and look for the zip file at the bottom of the page after the release notes. The zip directory you need is the third one from the top (named something like this with the version number in the name): **xmlcalabash-3.0.0-alpha17.zip**
    * Unzip this and move it somewhere central where it's easy to work with. I set my unzipped xmlcalabash folder in my GitHub directory so it's near where I work on code.
    * Open your shell and navigate to your new xmlcalabash folder. For this to work we need to be able to use Java to execute the .jar file inside.
       Test if your Java installation works. This 'help' shell command will show you all the different commands available:
          * `java -jar xmlcalabash-app-3.0.0-alpha18.jar help`
          * ADAPT THE LINE ABOVE TO APPLY YOUR VERSION NUMBER AS NEEDED!
          * (NOTE: on the XML Calabash repo, they left out the `.jar` portion of the filename, so their line won't work)
   * NOTE: **alpha18 release of 2 February 2025 indicates it is not backwards compatible with earlier releases** (Find out / test if we want a specific version?)

* Macs: Test if you have graphviz by entering this in your terminal: `dot -V` . Probably you need to install GraphViz, and you can do that with `brew install graphviz`. 
     * (Windows will need to install from https://graphviz.org/download/ )

* CoffeeSacks: Get this from the versioned releases on the repo, here: https://github.com/nineml/coffeesacks/releases and find the latest one to download.
* **Make the .xmlcalabash3* dot-file**: 
    * Navigate to your "home" directory (which is where you set up your .zshrc file and establish your aliases and environment variables and such like). In this location we'll be storing a dot-file which will help Calabash to run.
    * NOTE: We will NOT be using Saxon EE at all. We also need to know where Homebrew installed graphviz. Double-check by navigating to see if Homebrew installed it in the default location: `/opt/homebrew/bin/dot` .
        * In my (probably extra special and weird) case, it did not. I found out where graphviz was installed by typing in `where dot` and following the paths. Mine is "symlinked" from `/usr/local/bin` which eventually showed me my way to the exact location on my machine (which was `/usr/local/Cellar/graphviz/12.2.1/bin`). This may be because I've installed a few different versions of graphviz for Python and other applications over the years. Anyway, just check and make sure you know where Homebrew installed graphviz and its executable `dot`. You will need this path.
    * Back in your "home" directory, make the new file. You can copy in this command in your terminal: `touch .xmlcalabash3` (with that leading dot exactly like that). Here's what you'll need inside:

    
   **Default location for Homebrew Graphviz**
   ```xml
      <cc:xml-calabash xmlns:cc="https://xmlcalabash.com/ns/configuration">
         <cc:graphviz dot="/opt/homebrew/bin/dot"/>
      </cc:xml-calabash>
   ```

  (Dr. B's weird special case b/c Graphviz was installed elsewhere):    
   ```xml
      <cc:xml-calabash xmlns:cc="https://xmlcalabash.com/ns/configuration">
         <cc:graphviz dot="/usr/local/Cellar/graphviz/12.2.1/bin/dot"/>
      </cc:xml-calabash>
   ```
* We are not going to configure a special Saxon config file b/c we are going to use the default Saxon HE that comes packaged with Calabash.
* Now, we'll make an alias for running calabash. Open up your `.zsrhc` and add an alias line that makes sense for you to call it. Your alias needs to execute a pretty long command. 
    * You need to find where you installed Calabash (I put mine in my GitHub directory). You'll be pointing your script to the `xmlcalabash.sh` line inside.
    * Here's what my calabash execution alias looks like in my `.zshrc` file, giving it the name "calabash"

```
alias calabash='/Users/eeb4/Documents/GitHub/xmlcalabash-3.0.0-alpha18/xmlcalabash.sh --init:org.nineml.coffeesacks.RegisterCoffeeSacks'
```
    
   * *For future reference*: As soon as we have an XProc pipeline file (`.xpl`) ready to run, we'll be running with a command like this, using the alias you created: `calabash filename.xpl` ). And we can see some nifty graphviz sketches of our pipeline if we append this to the command (including the dot at the end: `--graphs:.` like so: `calabash filename.xpl --graphs:.`

=========================

# ixml processors

## CoffeePot
To be used with the XProc processor [**Calabash**](#calabash)

## Markup Blitz


  


