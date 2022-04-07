# Function in xslt

## What is function?

Function is a block of code to perform a specific task, including calculation, comparison and so on. 

## Why function?

When we need to perform a task repeatedly, we can consider defining a function for it to simplify our code.

This is a sample code without \<xsl:function>. It is to set text anchor for 4 different labels according to whether the label is on the left or right of the center of the pie chart. Just notice its length.

```xml
<!-- Set the text anchor for labels -->
<!-- $cx is the x-coordinate of the center of the pie chart. -->
<!-- $colorX, $natureX, $shapeX, $techX is the x-coordinate for 4 different labels, including color, nature, shape, and tech. -->

<xsl:variable name="colorTextAnchor">
    <xsl:choose><xsl:when test="$colorX &lt; $cx">end</xsl:when> 
        <xsl:otherwise>start</xsl:otherwise>
    </xsl:choose>     
</xsl:variable>

<xsl:variable name="natureTextAnchor">
    <xsl:choose><xsl:when test="$natureX &lt; $cx">end</xsl:when> 
        <xsl:otherwise>start</xsl:otherwise>
    </xsl:choose>     
</xsl:variable>

<xsl:variable name="shapeTextAnchor">
    <xsl:choose><xsl:when test="$shapeX &lt; $cx">end</xsl:when> 
        <xsl:otherwise>start</xsl:otherwise>
    </xsl:choose>     
</xsl:variable>

<xsl:variable name="techTextAnchor">
    <xsl:choose><xsl:when test="$techX &lt; $cx">end</xsl:when> 
        <xsl:otherwise>start</xsl:otherwise>
    </xsl:choose>     
</xsl:variable>
```

We can see that we have to repeat the same task 4 times since we have 4 labels to process. 

If we use \<xsl:function>, it will be simplified like:

```xml
<xsl:function name="yxj:textAnchor">
    <xsl:param name="xPos" as="xs:double"/>
    <xsl:choose>
        <xsl:when test="$xPos &lt; $cx">
            <xsl:sequence select="'end'"/>
        </xsl:when> 
        <xsl:otherwise>
            <xsl:sequence select="'start'"/>
        </xsl:otherwise>
    </xsl:choose>     
</xsl:function>
```

The length of code decreased significantly. We only need to code one time how to set the text anchor.

## How to use xsl:function in xslt?

### Set namespace firstly

If we want to use function in xslt, we need to define a custom (non-xslt) namespace for it. 

For example, we define the custom namespace as **ns**: 

```xml
xmlns:ns="http://anyNameIsFine"
```

Then, set the code above as an attribute of the element \<xsl:stylesheet> like below:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
   	xmlns:ns="http://anyNameIsFine">  <!-- This line is my custom namespace. -->
    
</xsl:stylesheet>
```

When we call the function name, we need to prefix the function name with the custom namespace, like below:

```xml
ns:function
```

### Define function

We need use three basic elements to define a function:

* \<xsl:function>

  * This element is used to name our function and define what datatype it returns.

  * Function name should prefix with our custom namespace, which is ```ns:``` here.

  * The return type can be integer, string, float, double......It should prefix with ```xs:```.

    ```xml
    <xsl:function name="ns:function_name" as="xs:return_type"
    ```

* \<xsl:param>

  * This element is used to define the name and datatype of parameter(s).

  * We can input multiple parameters if we need.

    ```xml
    <xsl:param name="parameter_name" as="xs:parameter_type"/> 
    ```

* \<xsl:sequence>

  * This element is to define the expression, which means what the function does. 

    ```xml
    <xsl:sequence select="here is for the expression"/>
    ```

#### Example of addition function

This function is named addition. It returns an xs:integer value. It has two parameters, named x and y separately, and both they are xs:integer. It outputs the sum of x and y.

```xml
<xsl:function name="ns:addition" as="xs:integer">
    <xsl:param name="x" as="xs:integer"/> 
    <xsl:param name="y" as="xs:integer"/>
    <xsl:sequence select="x + y"/>
</xsl:function>
```

### Call function

* Prefix the function name with our custom namespace. 

* Parameters are in parentheses. 

* Use ```,``` to separate multiple parameters.

#### Example of addition function

```xml
ns:addition(3, 4)
```

Output:

```
7
```

