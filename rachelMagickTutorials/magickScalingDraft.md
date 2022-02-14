# Thumbnail Generation and Batch Processing


Thumbnails are essential when browsing online; without them, every image would be displayed at full size, making image galleries impossible to navigate. 

A way to generate thumbnails without complicating a website's code is through a program called *Image Magick.* By installing the program, it connects with the *Git Bash Shell* to generate thumbnails for websites that do not interfere with the properties of the original files.

A computer's build and operating system will determine which version of the program is best. *Image Magick's* download links can be found [here.](https://imagemagick.org/script/download.php)

## Intro to *Image Magick*

*Image Magick* is an independent program, but is compatible with the Git Bash shell. Both inside and outside of a repository, it can generate thumbnails, rename images, change DPI, and convert file types among others. *Smashing Magazine* wrote an article discussing several of *Image Magick's* abilities, and the program's website lists all its abilities in addition to links for their tutorials. The link for it can be found [here.](https://imagemagick.org/script/command-line-options.php)

## Magick convert vs. Magick mogrify

 At this point, you should have set aside some images to batch process. There are two properties that are essential to the program, and cannot be confused with each other: **magick convert and magick mogrify.** What sets the two apart is that convert is designed for making changes to a single image while mogrify applies changes to all the images. 
 
  Convert is helpful for single images because it allows changes to be made to a single file, but it has the power to rename the thumbnail without changing the original file. An example of this can be seen below:
  
  ```
magick convert placeholder.png -thumbnail 200x200 -quality 72 somethingElse.png
```

if this code is correct, a duplicate of the placeholder image will be generated with a width of 200 (landscape) or height of 200 (portrait), a DPI of 72, with a name of "somethingElse.png". The file's output will be the same as the original, but this will change with additional code. Redirecting output will be discussed below.

Magick mogrify, meanwhile, is designed for batch processing. a folder with dozens of images can generate thumbnails with ease, but it is **not** recommended to rename the files during batch processing. 

This will result in all the images having the same name with numbers differentiating them. If a thumbnail needs to be renamed, do so **after** the thumbnails are processed and **before** running a git pull. This will prevent a future merge conflict. An example of magick mogrify can be seen below:
```
magick mogrify -thumbnail 200x200 -quality 72
```

By this logic, the images will have the same properties as the example for magick convert, but they will not have an output source or will be output in the same folder as their source. If either of the following occurs, refer to the section below.

##Magick Output

Output for magick convert and mogrify is essential. A folder should be dedicated to thumbnails if one doesn't exist already. if the output folder is in the same directory as the images, the code can be formatted like this:

```
magick mogrify -thumbnail 200x200 -quality 72 -path folder2 *.png
```

If the output folder is **above** the current folder/directory, use code like this:

```
magick mogrify -thumbnail 200x200 -quality 72 -path ../folder0 *.png
```

If the output is in a **lower** directory, use this code for output:

```
magick mogrify -thumbnail 200x200 -quality 72 -path folder2/folder3 *.png
```

Even if the number of directories the output has to ascend or descend change, the sequence for each will stay the same.```../``` will be repeated if the output ascends more than one directory, and for descending directories, more slashes can be used ```/folder2/folder3/folder4``` until the intended directory is reached.

## Uppercase vs. Lowercase File Formats

This is an important thing to note for imported files. When importing and downloading files, especially from mobile devices, files will take the form of ```.PNG``` and ```.JPEG```. This seems insignificant, but it will affect the amount of files processed.

If a file has an output of ```.png```, only files with the lowercase filetype will be processed. the best solution is to run the sequence twice, one with uppercase and the other with lowercase while keeping the output the same. This means that all the files will be processed to the same folder despite running multiple times. The command line picks and chooses which images to process, so a ```.PNG``` file will not be processed during a sequence focused on ```.png``` and guarantees that no duplicates will go through.

## Thumbnail vs. Resize

Most of the sample code for this tutorial uses the ```-thumbnail``` property, but it is not the only property for *Image Magick*; in fact, there are several. Thumbnail properties will attempt to match the width and height of the sequence while keeping the image's aspect ratio. This means that images will experience less squashing and stretching during processing. 

By contrast, the ```resize``` property will have the thumbnail generating the exact proportions at the cost of squashing and stretching the image dimensions. It's better for exact results, but less intuitive.

