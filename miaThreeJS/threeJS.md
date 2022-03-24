# Three.JS Tutorial - Create 3D Environments with HTML and Javascript



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

To do this, simply paste these `import` instructions on the first line of your file:

```
import * as THREE from 'https://unpkg.com/three@0.127.0/build/three.module.js';
```

