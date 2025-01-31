# Invisible XML / XProc 

We need help with developing and fine-tuning installation/configuration instructions:
<http://dh.obdurodon.org/ixml-and-xproc-configuration.xhtml> 

This is related to a tutorial under development at <http://dh.obdurodon.org/ixml-and-xproc-lesson-plan.xhtml> 
**********
MAC OS notes 

* Check version of java in terminal with `java -version`
     * Dr. B's version is java 19, so upgrading
     * Installing latest openjdk on Mac with homebrew: <https://ansidev.xyz/posts/2023-07-11-how-to-install-openjdk-on-macos>
     * **(Need instructions for Mac students to install Homebrew and set up sudo use for the first time)**
     * **Note** if uninstalling Oracle Java, follow these instructions: <https://www.java.com/en/download/help/mac_uninstall_java.html>
 
* Installing Calabash:
    * Get it from here: https://github.com/xmlcalabash/xmlcalabash3/releases/tag/3.0.0-alpha17 and look for the zip file at the bottom of the page after the release notes. The zip directory you need is the third one from the top (named something like this with the version number in the name): **xmlcalabash-3.0.0-alpha17.zip**
    * Unzip this and move it somewhere central where it's easy to work with. I set my unzipped xmlcalabash folder in my GitHub directory so it's near where I work on code.
    * Open your shell and navigate to your new xmlcalabash folder. For this to work we need to be able to use Java to execute the .jar file inside.
       Test if your Java installation works. This 'help' shell command will show you all the different commands available:
          * `java -jar xmlcalabash-app-3.0.0-alpha1.jar help`
          * (NOTE: on the XML Calabash repo, they left out the `.jar` portion of the filename, so their line won't work)

         
  


