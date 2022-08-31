# Setting up a Jekyll development environment for GitHub Pages 

## Wait, what is Jekyll anyway? 
Jekyll is a **static website generator**: It's a *generator* in that it helps automate the construction of your HTML pages, but it outputs a *static site* which means that visitors won't be triggering dynamic server-side interactions when they visit your page. Static sites can handle client-side Javascript interactions, but they don't fundamentally change their content when a visitor interacts with them.  

Jekyll is totally free, distributed under an open source MIT license for anyone to use in web development. It happens to be written in the **Ruby language** by one of the founders of GitHub ([Tom Preston-Werner](https://en.wikipedia.org/wiki/Tom_Preston-Werner)), and uses something called "liquid templating" in Ruby, which you'll be adapting and applying as you work with it. 

Even when you don't have Jekyll configured locally, you still use it when you publish a website on GitHub Pages. When we configure it locally, we can create templating that will help you to customize your website development with a standard layout for things like your header, footer, and navigation bar, and allow you to simplify the generation of content with "include" files.

## Okay, how do I get started setting this up?
To configure Jekyll in your own way, you need to install it locally. That requires installing Ruby first.

### Installing Ruby
Do you have Ruby installed already? Check.
Open your Terminal (Mac) or Git Bash shell (Windows) and at the command prompt enter:
```
ruby -v
```
When you press enter, you'll be told if you have Ruby or not. 
If you don't have it follow the instructions for your computer type below (Mac or Windows):

#### Install Ruby on Mac
If you're on a Mac, you most likely have Ruby already. (They say it comes with Ruby versions 2.0 and higher since 
El Capitan). 

If you don't have it or want the latest version, [get yourself Homebrew first](https://brew.sh/):
Homebrew is a very cool "package manager" for Mac for handling installations of libraries and languages like Ruby and Python. When you install something it plays a little game of pretending it's brewing casks of the finest beer or ale in your computer, and thereby establishing one of the reasons why we love Macs for installing and updating complicated things. Wait until you've installed Homebrew (it takes a little while), and when everything is ready, go to your Terminal and at the prompt type in:
```
brew install ruby
```


#### Install Ruby on Windows

Go to RubyInstaller for Windows: https://rubyinstaller.org/downloads/

Choose the Ruby+Devkit 3.1...(x64) version at the top and download its .exe file. 

Find the .exe file in your Downloads and click on it to run the installer. 

In the installer (if these are not already checked), check the box to "Add Ruby executables to your PATH." Also check the box to associate .rb and .rbw files with this Ruby installation.

Wait for it to finish installing, and click "Finish" on the screen to exit the installer.

This will open the Windows cmd.exe window and a cute Ruby 2 Installer screen. You'll be asked: "Which components shall be installed? Click "enter" to let it install in the default way.

To verify the installation is complete, open up the Git Bash again, and type in 
```
ruby -v
```
You should see the version of Ruby you installed. 








