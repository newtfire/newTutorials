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
El Capitan). But [the Jekyll developers advise](http://jekyllrb.com/docs/installation/macos/) that you should always install a more current Ruby than the one provided by the Mac OS. After a bit of testing, here's the command that seems to work best in the Terminal prompt:

```
brew install homebrew/portable-ruby/portable-ruby
```

To do these installations, [get yourself Homebrew first](https://brew.sh/):
Homebrew is a very cool "package manager" for Mac for handling installations of libraries and languages like Ruby and Python. When you install something it plays a little game of pretending it's brewing casks of the finest beer or ale in your computer, and thereby establishing one of the reasons why we love Macs for installing and updating complicated things. Wait until you've installed Homebrew (it takes a little while), and when everything is ready, go to your Terminal and at the prompt type in:


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

#### Finally, install Jekyll

On Mac, in your terminal enter:
```
gem install jekyll
```

**On Windows**, this doesn't seem to work in the Git Bash shell, apparently because some PATH modification needs to happen. So we recommend opening the native command prompt on your Windows computer (find Command Prompt on the Start menu). Open it and enter:

```
gem install jekyll
```

This takes a little while to install. You'll know it's complete when you see something like this:

```
Done installing documentation for sassc, jekyll-sass-converter, concurrent-ruby, i18n, http_parser.rb, eventmachine, em-websocket, colorator, public_suffix, addressable, jekyll after 12 seconds
Successfully installed bundler-2.3.21
Parsing documentation for bundler-2.3.21
Done installing documentation for bundler after 0 seconds
12 gems installed


```

## Set up your GitHub repo with Jekyll
Now you can begin work on your GitHub repo. For our context, I imagine that you are starting with a GitHub repo that is already sharing a website over GitHub Pages, but you could also be initiating a new GitHub repo. I recommend as you're learning to start with a website that you've already designed. 

*If redesigning a site, keep in mind that you will be changing the file structure for delivering your webpages.* So, in that case, let's not disturb the structure of your existing GitHub repo. Instead, we'll begin a new repo and adapt your files for your new website structure.  

Your Jekyll-powered website will need to be organized according to [Jekyll's file directory structure](http://jekyllrb.com/docs/structure/). Follow that link to get a sense of it. Notice that how the configuration folder and filenames begin with a leading underscore: `_.config.yml`, `_layouts`, etc.

Decide if you're going to work with a `docs/` directory. (Probably you should.) Create that docs/ directory in your repo.

### Set up a `.gitignore` file
The file begins with a dot because it is meant to be a hidden file in your repo. A `.gitignore` screens unwanted local files from being pushed to the cloud repo. We typically want to screen out system files generated by Mac or Windows operating systems like `.DS_Store` or `thumbs.db`, but in addition to that, we also need to screen out local system "build" files that you will be generating as you develop and test your website in your local computer. We need to screen these out because the cloud GitHub does its own Jekyll builds independent of yours consistent with the GitHub cloud environment, distinct from your local computer. 

You can take the text here and save it in a text file that you name `.gitignore`. NO File extension(!)
To make this easy, go to your Git Bash or Mac Terminal, navigate to the top level of your repo, and type in:

```
touch .gitignore
```

That creates an empty file named `.gitignore` that you can then open in a text editor or oXygen (as a text file). 
You can paste in my .gitignore text in the file, and save it and push it up to your repo.

```
# OS generated files #
######################
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
# Ruby/Jekyll local build files to screen out
_site/

```

### Install Jekyll in your repo: plant the Gemfile!
Just a few steps here: We need to install Jekyll, which will result in a special **Gemfile** being installed in the directory
where you want your website files to be stored. 

First enter this line:

```
bundle init
```
(The result should be something like this: "Writing new Gemfile to C:/your/special/filepath/to/your/repo/web-directory/")

Then enter:

```
bundle add jekyll
```

This will take a few minutes to fetch gem info and resolve dependencies and eventually return you to the command prompt. Wait for it. 

Look in your directory now and you'll find a file named `Gemfile` with no file extension. You will also see a Gemfile.lock. (Gem.lock is there to "lock" the gem versions you've installed in place until you're ready to update your bundle of gems—which you can do by entering the command `bundle update`.) 

Open the Gemfile (as a text file), and you'll see a few lines of code like this:

```
# frozen_string_literal: true

source "https://rubygems.org"

# gem "rails" 

gem "jekyll", "-> 4.2"
```

### Create the `_config.yml` file

YML means "YAML ain't markup language" (I'm serious). The `_config.yml` file is there to establish some basic information about your site and manage any plugins you might eventually supply. Let's start with a super simple YAML file to configure your site. (Obviously, you should customize this to your website's information). This is basically a text file that you save with the name `_config.yml` and save in the directory that will be publishing your website. **If you will be configuring GitHub Pages to publish from your `docs/` directory, save this in `docs/`**. 

```
title: Elisa Beshero's Portfolio Website
name: Elisa Beshero
description: representing my digital projects
timezone: America/New_York

```

### Install some useful plugins: Update the `Gemfile` and `_config.yml`
Let's install some useful Jekyll plugins now, if you like. We'll just install a few to start, but this process will orient you on how to add other plugins you may discover. 

* **jekyll-sitemap** : This creates a site map, which is helpful for **search engine optimization (SEO)** 
(it helps web crawling engines to optimize your site in search results)

* **jekyll-seo-tag** : This is good for SEO, too, because it adds helpful meta tags for the web crawling bots

* **jekyll-feed** : If you're creating blog posts, this is good for creating an RSS feed for your posts


1. To call for these plugins, start with the `Gemfile`: 
**Enter this code after the last line in your `Gemfile`**, to call for a Jekyll plugin group (and save the file)

```
group :jekyll_plugins do
  gem 'jekyll-sitemap'
  gem 'jekyll-seo-tag'
  gem 'jekyll-feed'
end
```

2. To be able to apply the plugins, we *also* need to add them to `_config.yml`.
Open up `_config.yml` and add the following lines (and save the file)

```
plugins:
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-sitemap
 
```

3. Now, time to install the plugins. Go to your Terminal (Mac) or Git Bash (Windows) and enter:

```
bundle update
```
Wait a second for this to update your gems! 

#### Using the plugins (seo-tag and RSS feed)

When you're ready with your website files and your default.html layout, you can call the plugins on your site something like this (taken from a sample **default.html** in the Jekyll documentation https://jekyllrb.com/docs/step-by-step/10-deployment/)
Notice how these get set in the `<head>` element in the HTML:

```
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>{{ page.title }}</title>
    <link rel="stylesheet" href="/assets/css/styles.css">
    {% feed_meta %}
    {% seo %}
  </head>
  <body>
    {% include navigation.html %}
    {{ content }}
  </body>
</html>

```


### TBD: `_layouts` and `_includes`

### Set up your cloud GitHub repo for GitHub Pages with GitHub Actions

At this point, go ahead and push your new code to the cloud repo. We should configure the repo to publish GitHub Pages.
We'll do this using **GitHub Actions**, which will be able to locate your Jekyll site wherever you build it in the repo. (We still recommend doing the site setup in a `docs/` directory if you want to archive other code outside the website files.)
GitHub Actions was introduced in late December 2021 and it contains lots of nifty automated testing and building features for Jekyll sites. 






### TBD: Building your site locally

In your (Mac) Terminal or (Windows) Git Bash, enter:

```
bundle exec jekyll serve
```

If this succeeds, Jekyll will locate your configuration files successfully and build your site in a new local `sites/` directory. Jekyll will also share a local URL served by your computer from a special port number. Copy and paste the local URL that Jekyll provides into a web browser. It'll look something like:

```
http://someNumbers.0.0.1:4000
```



### TBD: Publishing with GitHub Pages

## Resources and further reading

GitHub documentation on setting up a GitHub Pages site with Jekyll: 
https://docs.github.com/en/enterprise-server@3.1/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site

Jekyll documentation on Gemfiles and plugins for GitHub Pages: https://jekyllrb.com/docs/step-by-step/10-deployment/ 

Testing your GitHub Pages site locally with Jekyll: https://docs.github.com/en/enterprise-server@3.1/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll 



Jonathan McGlone's [Creating and Hosting a Personal Site on GitHub](http://jmcglone.com/guides/github-pages/index.html)
 
 * Why I like this: It shows you the *least* that you need to set up a simple Jekyll site.
 * Scroll down to "Using Jekyll with GitHub Pages"
 * * **Read this for the web architecture.** Don't do this stuff in the web interface if you already know how to work with git at command line.

#### Resources for SEO and Analytics

* Generate an XML sitemap for search engine optimization: https://github.com/marketplace/actions/generate-sitemap
 * Add Google Analytics to GitHub Pages: https://www.christopherlovell.co.uk/blog/2015/04/13/google-analytics-ghpages.html


