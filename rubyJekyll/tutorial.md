# Setting up a Jekyll development environment for GitHub Pages 

## Wait, what is Jekyll anyway? 
Jekyll is a **static website generator**: It's a *generator* in that it helps automate the construction of your HTML pages, but it outputs a *static site* which means that visitors won't be triggering dynamic server-side interactions when they visit your page. Static sites can handle client-side Javascript interactions, but they don't fundamentally change their content when a visitor interacts with them.  

Jekyll is totally free, distributed under an open source MIT license for anyone to use in web development. It happens to be written in the **Ruby language** by one of the founders of GitHub ([Tom Preston-Werner](https://en.wikipedia.org/wiki/Tom_Preston-Werner)), and uses something called "liquid templating" in Ruby, which you'll be adapting and applying as you work with it. 

Even when you don't have Jekyll configured locally, you still use it when you publish a website on GitHub Pages. When we configure it locally, we can create templating that will help you to customize your website development with a standard layout for things like your header, footer, and navigation bar, and allow you to simplify the generation of content with "include" files.

## Okay, how do I get started setting this up?
To configure Jekyll in your own way, you need to install it locally. That requires installing Ruby first.

### Installing Ruby


