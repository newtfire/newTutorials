<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:output method="xml" indent="yes"/> 
    
    <xsl:variable name="cx" select="0"/>
    <xsl:variable name="radius" select="150"/>
    <xsl:variable name="circumf" select="2 * math:pi() * $radius"/>
    <xsl:variable name="labelRadius" select="2*$radius + 100"/>
    <xsl:variable name="font-size" select="30"/>
    
    <!-- variable for decoration -->
    <xsl:variable name="line" select="10"/>
    
    <xsl:variable name="total" select="//page/*[not(self::line)][not(self::description)]! name() => count()"/>
    <xsl:variable name="color" select="//color => count()"/>
    <xsl:variable name="nature" select="//nature => count()"/>
    <xsl:variable name="shape" select="//shape => count()"/>
    <xsl:variable name="tech" select="//tech => count()"/>
    
    
    <!-- Can we generate new variables with XSLT? -->
    
    <xsl:variable name="valueArray">
        <xsl:value-of select="($color, $nature, $shape, $tech)"/>        
    </xsl:variable>
    <xsl:variable name="percentArray"> 
      <xsl:for-each select="$valueArray">
        <xsl:value-of select="current() div $total"/>
   </xsl:for-each>
  </xsl:variable>
    
    <xsl:variable name="radianArray">
        <xsl:for-each select="$percentArray">
            <xsl:value-of select="current() * 2 * math:pi()"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="midArcArray">
        <xsl:for-each select="$radianArray">
            <xsl:variable name="pos" select="position()"/>
            
            <xsl:variable name="preceding">
                <xsl:for-each select="$radianArray[position() lt $pos]">
                <xsl:value-of select="current()"/>
                </xsl:for-each>
            </xsl:variable>
      <xsl:value-of select="current() div 2 + sum($preceding)"/>    
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="labelXPositions">
        <xsl:for-each select="$midArcArray">
            <xsl:value-of select="$labelRadius * math:cos(current()) "/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="labelYPositions">
        <xsl:for-each select="$midArcArray">
            <xsl:value-of select="$labelRadius * math:sin(current()) "/>
        </xsl:for-each>
    </xsl:variable>
    
    
    <xsl:template match="/">
        <svg width="600px" viewBox="-100 100 1200 800">
            <g transform="translate(500, 500)">
                
                <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}"  stroke="palegreen"/>
                
               <!--2022-03-24 ebb: 
               We are just experimenting right now with plotting a simple pale green circle, and to see if 
               we can work through an array of values to plot labels inside it. 
               
               We will add the stroke-dasharray pie slices later. 
               
               Try using a <xsl:for-each> statement to plot labels based on their position in $valueArray.
               
               Define a variable to store the current position in the $valueArray:
               <xsl:variable name="pos" select="current()/position()"/>
               
              Can we call $labelXPositions[position() = $pos] to plot the X coordinate? 
              Can we call $labelXPositions[position() = $pos] to plot the X coordinate? 
               
               We should explore writing xsl:functions to handle the calculations and positioning of coordinates. 
               The function could involve testing whether the values less than the cx value, 
               and output a - or + value accordingly. 
               
              My suggestions for the tutorial include:
              * Add a new image of the polar coordinate system that represents SVG as different from 
              how we usually look at it. 
              
              * Add link to resource for learning SVG path (w3schools) [already added. :-) ]
              
              * Explain why we would want to use <path>. 
              
              * Explain why we would use the text end-anchor, as well ("for beauty" to prevent overlap, etc. etc)
              
              * You do not need to write a tutorial on radians. But you could link to a good site to explain it. 
               
               --> 
                
                
            </g>
        </svg>
        
        
        
    </xsl:template>
    
    
    
   
</xsl:stylesheet>