# SVG Animation Review

This tutorial introduces how to make animation with svg and css in html.

The icons on the top of the sites are really cool, which raises my interest in this tutorial.

The step 2 shows a way to declare color variables in css, so that we can use them for SVG elements. I really like this idea to store the color we need. Default colors, like yellow, purple, and so on often are not ideal, and using custom colors with rbg() or hexadecimal color code may reduce code readability. This way can let us set custom color and keep high code readability.

All sample codes and output animations are clear. 

Still, I'm a little confused when I read the part of transform:rotate(). I hope more explanation about it. 

For example, in the first animation for rotate, we can see the blue line flies outside of canvas. I'm curious why this happens. Perhaps the default origin of the blue line or any other svg element is the origin of svg canvas?

Also,  transform-origin:center looks not work very well, because when the element rotates, it seems to have moved positions, but we have not let it move. The center seems not to mean the center of the element, so what the center exactly means?

Additionally, I suggest to reorganize the codes in css. For example, the code for #scale of #yellowCircle should be before that for #badscale of #yellowCircle, because in the tutorials, it introduces the bad one before the good one. When I learn the codes in css, I found I could not locate the code very well because some of them is disorder.
