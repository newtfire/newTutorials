# Setting up a Jekyll development environment for GitHub Pages 
Probably you are beginning with a GitHub repo that is hosting a website using GitHub Pages, but without working with Ruby or Jekyll locally. You could also follow this tutorial if you are starting a new GitHub Pages website to work with a Jekyll development environment. 

## Wait, what is Jekyll anyway? 
Jekyll is a **static website generator**: It's a *generator* in that it helps automate the construction of your HTML pages, but it outputs a *static site* which means that visitors won't be triggering dynamic server-side interactions when they visit your page. Static sites can handle client-side Javascript interactions, but they don't fundamentally change their content when a visitor interacts with them.  

Jekyll is totally free, distributed under an open source MIT license for anyone to use in web development. It happens to be written in the **Ruby language** by one of the founders of GitHub ([Tom Preston-Werner](https://en.wikipedia.org/wiki/Tom_Preston-Werner)), and uses something called "liquid templating" in Ruby, which you'll be adapting and applying as you work with it. 

Even when you don't have Jekyll configured locally, you still use it when you publish a website on GitHub Pages. When we configure it locally, we can create templating that will help you to customize your website development with a standard layout for things like your header, footer, and navigation bar, and allow you to simplify the generation of content with "include" files.

## Okay, how do I get started setting this up?
To configure Jekyll in your own way, you need to install it locally. That requires installing Ruby first.

### Installing Ruby
Here, you want to follow [Jekyll's instructions for installing Ruby on your system](http://jekyllrb.com/docs/installation/).

Do you have Ruby installed already? Check.
Open your Terminal (Mac) or Git Bash shell (Windows) and at the command prompt enter:
```
ruby -v
```
When you press enter, you'll be told if you have Ruby or not. 
If you don't have it follow the instructions for your computer type below (Mac or Windows):

#### Install Ruby on Mac
If you're on a Mac, you most likely have Ruby already. (They say it comes with Ruby versions 2.0 and higher since 
El Capitan). But [the Jekyll developers advise](http://jekyllrb.com/docs/installation/macos/) that you should always install a more current Ruby than the one provided by the Mac OS. 

To get the latest version, [get yourself Homebrew first](https://brew.sh/):
Homebrew is a very cool "package manager" for Mac for handling installations of libraries and languages like Ruby and Python. When you install something it plays a little game of pretending it's brewing casks of the finest beer or ale in your computer, and thereby establishing one of the reasons why we love Macs for installing and updating complicated things. Wait until you've installed Homebrew (it takes a little while), and when everything is ready, go to your Terminal and at the prompt type in:
```
brew install ruby###
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

### Got Ruby? Now install the Bundler!
You'll need to install the Bundler next. What is this for? It's basically for your website configuration to be able to call on any "Ruby gems" you need. Jekyll is a Ruby gem, and you'll need Bundler to be able to read the **Gemfile** or the configuration of Ruby gems you'll be using.  

Install Bundler (in either Mac Terminal or Git Bash on Windows) with:

```
gem install bundler
```

### Set up your GitHub repo with Jekyll
Now you can begin work on your GitHub repo. For our context, I imagine that you are starting with a GitHub repo that is already sharing a website over GitHub Pages, but you could also be initiating a new GitHub repo. I recommend as you're learning to start with a website that you've already designed. 

*If redesigning a site, keep in mind that you will be changing the file structure for delivering your webpages.* So, in that case, let's not disturb the structure of your existing GitHub repo. Instead, we'll begin a new repo and adapt your files for your new website structure.  

Your Jekyll-powered website will need to be organized according to [Jekyll's file directory structure](http://jekyllrb.com/docs/structure/). Follow that link to get a sense of it. Notice that how the configuration folder and filenames begin with a leading underscore: `_.config.yml`, `_layouts`, etc.

#### Create the `_config.yml` file

YML meant "YAML ain't markup language" and it's there to establish some basic information about your site and manage any plugins you might eventually supply. Let's start with a super simple YAML file to configure your site. (Obviously, you should customize this to your website's information). This is basically a text file that you save with the name `_config.yml` and save in the directory that will be publishing your website. If you will be configuring GitHub Pages to publish from your `docs/` directory, save this in `docs/`. 

```
title: Elisa Beshero's Portfolio Website
description: representing my digital projects

```



## Resources and further reading

GitHub documentation on setting up a GitHub Pages site with Jekyll: 
https://docs.github.com/en/enterprise-server@3.1/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site


 Jonathan McGlone's [Creating and Hosting a Personal Site on GitHub](http://jmcglone.com/guides/github-pages/index.html)
     * Why I like this: It shows you the *least* that you need to set up a simple Jekyll site.
     * Scroll down to "Using Jekyll with GitHub Pages"
     * **Read this for the web architecture.** Don't do this stuff in the web interface if you already know how to work with git at command line.



