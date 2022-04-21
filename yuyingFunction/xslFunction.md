# User-defined Function in XSLT

## What is function?

Function is a block of code to perform a specific task, including comparison, calculation, generating tables and so on. In XSLT, we use ```<xsl:function>``` to create a user-defined function.

## Why function?

When we need to perform a task repeatedly, we can consider defining a function for it to simplify our code.

This is a sample code without ```<xsl:function>```. It is to set text anchor for 4 different labels according to whether the label is on the left or right of the center of the pie chart. Just notice its length.

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

If we use ```<xsl:function>```, it will be simplified:

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

## How to define function in XSLT?

### Set namespace firstly

If we want to use function in xslt, we need to define a custom (non-xslt) namespace for it. Its value looks like URLs because it is an old custom of the markup language community.

For example, we define the custom namespace as **ns**: 

```xml
xmlns:ns="http://anyNameIsFine"
```

Then, set the code above as an attribute of the element \<xsl:stylesheet> like below:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0"
   	xmlns:ns="http://anyNameIsFine">  <!-- This line is my custom namespace. -->
    
</xsl:stylesheet>
```

When we call the function name, we need to prefix the function name with the custom namespace, like below:

```xml
ns:function
```

### Function Declaration and Definition

A function consists of **declaration** and **definition**. We have three basic elements to define a function, including ```<xsl:funtion>```, ```<xsl:param>```, and ```<xsl:sequence>```.

**Function declaration**

* ```<xsl:funtion>``` is to define:
  * function name (prefix with our custom namespace)
  
  * return type: the data type of the value returned
  
* ```<xsl:param>``` is to define:
* parameters name 
  
* parameter type: the data type of the value input

**Function definition**

* ```<xsl:sequence>``` is to define:
  * what the function executes.

##### Why ```<xsl:sequence>```?

Both ```<xsl:value-of>``` and ```<xsl:sequence>``` can return the result of function. However, ```<xsl:value-of>``` returns a text node, while ```<xsl:squence>``` can return a value with any specific data type we expecting. 

We will talk about what data type is and what data types we have in XSLT below.

#### Example: Add two numbers

```xml
<xsl:function name="ns:addition" as="xs:integer">
    <xsl:param name="x" as="xs:integer"/> 
    <xsl:param name="y" as="xs:integer"/>
    <xsl:sequence select="$x + $y"/>
</xsl:function>
```

* ```<xsl:function>```
  * function name:  ```ns:addition```
  * return datatype: ```xs:integer```

* ```<xsl:param>```
  * parameter name: ```x``` and ```y```
  * parameter type: both are ```xs:integer```

* ```<xsl:sequence>```
  * what to execute: ```$x + $y```


#### What is data type?

Each data type has a specific value range and operation can be applied to such variable. With data types, the editor can return errors when we using variables with an incompatible operation . For example, we could not divide a string by a number. 

##### Table 1. All basic data types in XML/XSLT

| Type                   | Description                                                  | Type                   | Description                                                  |
| ---------------------- | ------------------------------------------------------------ | ---------------------- | ------------------------------------------------------------ |
| **string**             | Any character                                                | **normalizedString**   | A whitespace normalized string where all spaces, tabs, carriage return and line feed characters are converted to single spaces |
| **token**              | A string that does not contain a sequence of two or more spaces, tabs, carriage return and line feed characters | **byte**               | A numeric value from -128 to 127                             |
| **unsignedByte**       | A numeric value from 0 to 255                                | **hex64Binary**        | Base 64 encoded binary information                           |
| **hexBinary**          | Hexadecimally encoded binary information                     | **integer**            | A numeric value representing a whole number                  |
| **positiveInteger**    | An integer whose value is greater than 0                     | **negativeInteger**    | An integer whose value is less than 0                        |
| **nonNegativeInteger** | An integer whose value is 0 or greater than 0                | **nonPositiveInteger** | An integer whose value is 0 or less than 0                   |
| **int**                | A numeric value from -2 147 483 648 to 2 147 483 647         | **unsignedInt**        | A numeric value from 0 to 4 294 967 295                      |
| **long**               | A numeric value from -9 223 372 036 854 775 808 to 9 223 372 036 854 775 807 | **unsignedLong**       | A numeric value from 0 to 18 446 744 073 709 551 615         |
| **short**              | A numeric value from -32 768 to 32 767                       | **unsignedShort**      | A numeric value from 0 to 65 535                             |
| **decimal**            | A numeric value that may or may not contain a fractional part | **float**              | Any 32-bit floating-type real number e.g. 1E4, 1267.43233E12, 12.78e-2, 12 |
| **double**             | Any 64-bit floating-type real number e.g. 1E4, 1267.43233E12, 12.78e-2, 12 | **Boolean**            | A logical value including True, False, 0 and 1               |
| **time**               | An instant of time that recurs everyday in the format HH:MM:SS e.g.12:30:00, this time references UTC (Coordinated Universal Time) | **date**               | Date value in the format YYYY-MM-DD                          |
| **dateTime**           | A combine date and time value in the format YYYY-MM-DD HH:MM:SS | **duration**           | Length of a time interval in the extended format e.g.P1Y1M1D1H1M1S = 1 Year + 1 Month + 1 Day + 1 Hour + 1 Minute +1 Second |
| **gMonth**             | A Gregorian (Calendar) Month, the month (MM) part of a Date  | **gYear**              | A Gregorian (Calendar) Year, the year (YYYY) part of a Date  |
| **gYearMonth**         | A Gregorian Year and Month, the year-month (YYYY-MM) part of a Date | **gDay**               | A Gregorian Day, the day (DD) part of a Date                 |
| **gMonthDay**          | A specific day of the month, the month-day (MM-DD) part of a Date | **Name**               | A string based on a well-formed element and attribute naming rules |
| **QName**              | The fully qualified XML Namespace name e.g. if the namespace is defined as `xmlns:html="http://www.w3.org/1999/xhtml"` the qualified name for `<html:p>` resolves to `{http://www.w3.org/1999/xhtml}p` | **NCName**             | The part of the namespace name to the right of the namespace prefix and colon e.g. if the namespace is defined as `xmlns:html="http://www.w3.org/1999/xhtml"` the NCName would be `html="http://www.w3.org/1999/xhtml"` |
| **anyURI**             | Represents the URI (Universal Resource Identifier) and can contain a URL or URN | language               | A language constant as defined in RFC 1766, e.g. `en-us` ([RFC 1766](http://www.ietf.org/rfc/rfc1766.txt), [ISO 639 Language Codes](http://www.w3.org/WAI/ER/IG/ert/iso639.htm)) (accessed September 2005) |

*Source: [XML Data Types [Online]. (2005). K2 blackpearl Help.](https://help.nintex.com/en-US/k2blackpearl/userguide/4.6.10/XML_Data_Types.html)*

### Calling a function

Notice:

* Calling function in the element ```<xsl:template>```.
* Using ```<xsl:value-of>``` to get the value of function returning.
* Prefixing the function name with our custom namespace. 
* Parameters are in parentheses. 
* Using ```,``` to separate multiple parameters.

#### Example: Calling the addition function

This is a complete XSLT stylesheet. We can check where the function is called.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0"
    xmlns:ns="http://anyNameIsFine">

    <!-- defining the function -->
    <xsl:function name="ns:addition" as="xs:integer">
        <xsl:param name="x" as="xs:integer"/> 
        <xsl:param name="y" as="xs:integer"/>
        <xsl:sequence select="$x + $y"/>
    </xsl:function>

    <!-- calling the function in <template> -->
    <xsl:template match="/">
        <html>
            <head></head>
            <title></title>
        </html>
        <body>
            <!-- calling the function with the element <xsl:value-of> -->
            <p>3 + 4 = <xsl:value-of select="ns:addition(3, 4)"/></p>
        </body>
    </xsl:template>
</xsl:stylesheet>
```

Output:

```html
<html xmlns:ns="http://anyNameIsFine">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   </head>
   <title></title>
</html><body xmlns:ns="http://anyNameIsFine">
   <p>3 + 4 = 7</p>
</body>
```

## 













