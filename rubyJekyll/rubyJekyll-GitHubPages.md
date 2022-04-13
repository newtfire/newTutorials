# Ruby Jekyll Environment for GitHub Pages


## Resources for setup
* [Creating a GitHub Pages Site with Jekyll](https://docs.github.com/en/enterprise-server@3.1/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll)
     * [Installing Ruby](https://www.ruby-lang.org/en/documentation/installation/)
     * [Installing Bundler package manager for Ruby](https://bundler.io/)
     * Simple Ruby/Jekyll model site: 
          * Code view: <https://github.com/newtfire/rubyJekyll> 
          * published site: <https://newtfire.github.io/rubyJekyll/>
* [Setting up a GitHub Pages Site with Jekyll](https://docs.github.com/en/enterprise-server@3.1/pages/setting-up-a-github-pages-site-with-jekyll/adding-content-to-your-github-pages-site-using-jekyll) 
     * Super developed ruby/jekyll site with a modified theme:
          * Code view: <https://github.com/ebeshero/UpTransformation>
          * published site: <https://ebeshero.github.io/UpTransformation/>

## Setup notes
* Don't put any files in the `docs/` directory: Start with an empty directory for hosting the website. Navigate to that directory and run `jekyll new --skip-bundle .` (as instructed)
* To serve your site locally run: `bundle exec jekyll serve`
* Preview in a web browser at `http://localhost:4000`
* Create a `.gitignore` file and add `_site/` so that your locally built files don't get tracked by git commits.
* When attempting to run locally, you may see an error that jekyll "cannot load such file -- webrick (LoadError)". [If you see this](https://github.com/jekyll/jekyll/issues/8523), you just need to add this gem to your Gemfile: 
`gem "webrick"`

## A really good guide to Jekyll site architecture in a GitHub repo
* Jonathan McGlone's [Creating and Hosting a Personal Site on GitHub](http://jmcglone.com/guides/github-pages/index.html)
     * Why I like this: It shows you the *least* that you need to set up a simple Jekyll site.
     * Scroll down to "Using Jekyll with GitHub Pages"
     * **Read this for the web architecture.** Don't do this stuff in the web interface if you already know how to work with git at command line.

* Your YML file can be super simple if you're *not* using a Jekyll theme
* [Choose the **markdown renderer**](https://jekyllrb.com/docs/configuration/markdown/) to translate markdown syntax into HTML on your site: kramdown is GitHub's default. Indicate this in your Yaml
    * You can add [syntax highlighting by installing the CodeRay gem](https://github.com/kramdown/syntax-coderay), and configuring it in your YML file. 

    
## Site architecture notes
* [Read about Jekyll themes](https://jekyllrb.com/docs/themes/) and how they're installed as gem files, what they do for you, and how you can modify them.
* You don't have to use Jekyll's themes. 
     * In the **Gemfile** for your site, you can comment out the default theme for new Jekyll sites:
	`gem "minima", "~> 2.5"`
	* Also in the **config.yml** file, comment out the line `theme: minima` 
     * You could also choose to [keep this theme and modify it](https://urishx.github.io/2020/12/16/Customizing-Jekyll%27s-default-theme.html). 
     * Or change the theme to something else you like   

