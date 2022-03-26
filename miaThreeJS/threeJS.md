# Three.JS Tutorial - Create 3D Environments with HTML and Javascript


## Step 1: *Install the Three.JS node package module using your Terminal/Command Line*

Before we dive into making our awesome 3D website, we need to install `Node.js` and `npm` at the command line.

- **Hot tip**: Assuming you're reading this because you're in one of Dr. B's classes, you're probably using oXygen as your code editor. oXygen is really great for working with XML, XSLT, and many other XML-based languages - but for languages like Javascript, where methods and functions are hard to remember for beginners, oXygen does not provide very good syntax highlighting and helpful suggestions as you code.
- **FOR THIS REASON**, we recommend downloading [Visual Studio Code](https://code.visualstudio.com/) to develop your three.js websites in. It's completely free, and it is simply the best for writing Javascript. You'll never want to write Javascript in any other code editor ever again. (Sorry Dr. B lol)
- you dont *neeeeed* VS Code to make your Three.JS website... but I'm tellin ya, it's just way better. You'll see what I mean.

### **Install Node.js**

Node.JS is what makes the Javascript world go round. 

"As an asynchronous event-driven JavaScript runtime, Node.js is designed to build scalable network applications." *-Node.JS devs*

Before downloading Node.JS, you should check to see if you already have it installed in your machine.
To do this, we will open our Command Line.

- **Hot tip part 2:** VS code actually has a command line terminal built into the editor that you can use as well:

![VS code terminal](images/screenshots/VScodeTerminal.jpg)

- Enter this command to check if you already have Node.JS Installed:
  ```
    node -v
  ```

 If you already have Node.JS installed, the terminal will print a version number that looks something like this: `v0.10.35`

 If your terminal didn't print a version number, you need to go [download Node.JS](https://nodejs.org/en/). (Don't worry, it's completely free - and if you really want to get into Javascript on any level, including professionally, Node.JS is a must-have.)

 ### **Install NPM**

Now that you have Node.JS installed, allow me to introduce you to the wonderful world of the **[Node Package Manager (NPM)](https://www.npmjs.com/)** community. NPM allows brilliant developers to write awesome open-source Node.JS package modules that will allow you to do super cool things with Javascript, including make 3D websites. We need to install NPM at the command line in order to install the Three.JS package.

- First, check to see if you already have NPM installed:

```
npm -v
```

Again, similar to when we checked for node.js, a version number will print if you already have npm installed. 
- If not, you need to install it. We can do this at the command line with this command:

```
npm install -g npm
```

Now you're all set to create your new project repository!

### **Create an empty project directory, and install THREE.js**

Once you have made your project directory, open the command line at your empty directory and enter this command:

```
npm install --save three
```

You should see a new `node_modules` directory, a `package.json` file, and a `package-lock.json` file. 

- **DO NOT TOUCH THESE THINGS**

These files and directory contain dependencies that NPM automagically generates for you. Humans do not need to touch them directly, and should never touch them for any reason at all - *or you'll destroy the planet*




## Create your HTML

You'll need three basic elements in your HTML to render your 3D world:
- `<canvas>` with a unique `@id` that will literally act as the canvas for your 3D objects to live in.
- `<script type="module" src="./main.js">` to connect your HTML to your Javascript file with all fo the 3D instructions inside it.
- `<main>` to hold the text contents that will float on top of your 3D environment.

It should look something like this:

```
<!DOCTYPE html>
<html>
    <head>
        <title>Three JS Demo</title>
        <meta charset="UTF-8" />
        <meta name="author" content="Mia Borgia" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="threeJSstyle.css" />
    </head>
    <body>
        <canvas id="bg"></canvas>
        <script type="module" src="./main.js"></script>
        <main>
            <header>
                Welcome to the world of Three.JS!
            </header>
            <section>
                <div>
                    <p>
                        The possibilities are endless! 
                    </p>
                </div>
            </section>
        </main>
    </body>
</html>
```

## Create your CSS and JS files

In the same directory as your index.html file, create your CSS and JS files. 

We won't mess with your CSS just yet, but it's nice to have all of your necessary documents at the ready right off the bat.

# Javascript Time!

In your new javascript file, you'll need to tell it to import the Three.JS node package module in order to reference the many pre-built 3D-building methods and objects.

To do this, simply paste these `import` instructions on the first line of your JS file:

```
import * as THREE from 'https://unpkg.com/three@0.127.0/build/three.module.js';
```



