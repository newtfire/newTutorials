<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0"
    xmlns:ns="http://anyNameIsFine">
    
    <xsl:function name="ns:addition" as="xs:integer">
        <xsl:param name="x" as="xs:integer"/> 
        <xsl:param name="y" as="xs:integer"/>
        <xsl:sequence select="$x + $y"/>
    </xsl:function>
    
    <xsl:template match="/">
        <html>
            <head></head>
            <title></title>
        </html>
        <body>
            <p>3 + 4 = <xsl:value-of select="ns:addition(3, 4)"/></p>
        </body>
    </xsl:template>
</xsl:stylesheet>