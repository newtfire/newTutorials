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

