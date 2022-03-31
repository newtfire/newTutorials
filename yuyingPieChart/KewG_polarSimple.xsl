<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns:yxj="http://yxj5181">
    
    <xsl:output method="xml" indent="yes"/> 
    
    <xsl:variable name="cx" select="0"/>
    <xsl:variable name="radius" select="150"/>
    <xsl:variable name="circumf" select="2 * math:pi() * $radius"/>
    <xsl:variable name="labelRadius" select="2*$radius + 100"/>
    <xsl:variable name="font-size" select="30"/>
    <xsl:variable name="typeArray" select="'color', 'nature', 'shape', 'tech'"/>
    <xsl:variable name="strokeArray" select="('palegreen', 'lightblue', 'blanchedalmond', 'pink')"/>
    <xsl:variable name="line" select="10"/>
    
    <xsl:variable name="total" select="//page/*[not(self::line)][not(self::description)]! name() => count()"/>
    <xsl:variable name="typeCounter" select="//page/*[not(self::line)][not(self::description)]! name() => distinct-values() => count()"/>
    <xsl:variable name="color" select="//color => count()"/>
    <xsl:variable name="nature" select="//nature => count()"/>
    <xsl:variable name="shape" select="//shape => count()"/>
    <xsl:variable name="tech" select="//tech => count()"/>
    
    
    <!-- Can we generate new variables with XSLT? -->
    
    <xsl:variable name="valueArray">
        <xsl:value-of select="($color, $nature, $shape, $tech)"/>        
    </xsl:variable>
    
    <xsl:variable name="percentArray"> 
        <xsl:for-each select="tokenize($valueArray, ' ')">
            <xsl:value-of select="string(number(.) div $total),''"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="radianArray">
        <xsl:for-each select="tokenize($percentArray, ' ')">
            <xsl:value-of select="string(number(.) * 2 * math:pi()),''"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="midArcArray">
        <xsl:for-each select="tokenize($radianArray[position() &lt;= $typeCounter], ' ')">
            <xsl:variable name="pos" select="position()"/>
            <xsl:variable name="preceding">
                <xsl:for-each select="tokenize($radianArray, ' ')[position() &lt; $pos]">
                    <xsl:value-of select=".,''"/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="string(number(.) div 2 + sum(for $i in tokenize($preceding[position() &lt; $pos]) return number($i))),''"/>    
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="midXPos">
        <xsl:for-each select="tokenize($midArcArray, ' ')[position() &lt;= $typeCounter]">
            <xsl:value-of select="string(2*$radius * math:cos(number(.))),''"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="midYPos">
        <xsl:for-each select="tokenize($midArcArray, ' ')[position() &lt;= $typeCounter]">
            <xsl:value-of select="string(2*$radius  * math:sin(number(.))),''"/>
        </xsl:for-each>
    </xsl:variable>
    

    <xsl:variable name="labelXPos">
        <xsl:for-each select="tokenize($midArcArray, ' ')[position() &lt;= $typeCounter]">
            <xsl:value-of select="string($labelRadius * math:cos(number(.))),''"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="labelYPos">
        <xsl:for-each select="tokenize($midArcArray, ' ')[position() &lt;= $typeCounter]">
            <xsl:value-of select="string($labelRadius * math:sin(number(.))),''"/>
        </xsl:for-each>
    </xsl:variable>
    

    
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
    
    <xsl:function name="yxj:lineDirection">
        <xsl:param name="xPos" as="xs:double"/>
        <xsl:choose>
            <xsl:when test="$xPos &lt; $cx">
                <xsl:sequence select="-$line"/>
            </xsl:when> 
            <xsl:otherwise>
                <xsl:sequence select="$line"/>
            </xsl:otherwise>
        </xsl:choose>     
    </xsl:function>
    
    
    
    
    <xsl:template match="/">
        <svg width="600px" viewBox="-100 100 1200 800">
            <g transform="translate(500, 500)">

                <xsl:for-each select="1 to $typeCounter">
                    
                    <xsl:variable name="index" select="$typeCounter + 1 -current()"/>
                    <xsl:variable name="percents" select="tokenize($percentArray, ' ')[position() &lt;= $index]"/>           
                    <xsl:variable name="sumPercents">
                        <xsl:value-of select="sum(for $i in $percents[position() &lt;= $index] return number($i))"/>  
                    </xsl:variable>
                    
                    <xsl:variable name="t_labelXPos" select="number(tokenize($labelXPos, ' ')[$index])"/>
                    <xsl:variable name="t_labelYPos" select="number(tokenize($labelYPos, ' ')[$index])"/>
                    <xsl:variable name="t_midXPos" select="number(tokenize($midXPos, ' ')[$index])"/>
                    <xsl:variable name="t_midYPos" select="number(tokenize($midYPos, ' ')[$index])"/>
                    
                    
                    <!--percentArray: <xsl:value-of select="$percentArray"/>
                    radianArray: <xsl:value-of select="$radianArray"/>
                    midArcArray: <xsl:value-of select="$midArcArray"/>
                    midXPos: <xsl:value-of select="$midXPos"/>
                    midYPos: <xsl:value-of select="$midYPos"/>
                    percent: <xsl:value-of select="$percents"/>
                    sumPercent: <xsl:value-of select="$sumPercents"/>-->
                    
                    
                    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}"
                            stroke-dasharray="{$circumf * $sumPercents, $circumf}"
                            stroke="{$strokeArray[current()]}"/>
                    
                    <text x="{$t_labelXPos}" 
                        y="{$t_labelYPos}" 
                        text-anchor="{yxj:textAnchor($t_midXPos)}"
                        font-weight="bold" font-size="30">
                        <xsl:value-of select="$typeArray[$typeCounter + 1 -current()]"/>:
                        <xsl:value-of select='format-number(number($percents[$index])*100,"#.00")'/>%
                    </text>
                    
                    <path d="M{$t_midXPos} {$t_midYPos} 
                            L{$t_midXPos + yxj:lineDirection($t_midXPos)} 
                             {$t_labelYPos + 10 -$font-size div 2} 
                            H{$t_labelXPos - yxj:lineDirection($t_midXPos)}"
                        stroke="grey" stroke-width="3" fill="none"/>
                    
                    <circle cx="{$t_labelXPos - yxj:lineDirection($t_midXPos)}" 
                            cy="{$t_labelYPos + 10 - $font-size div 2}" 
                            r="6" fill="grey"/>
                </xsl:for-each>
                
                
                
                
               <!--2022-03-24 ebb: 
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