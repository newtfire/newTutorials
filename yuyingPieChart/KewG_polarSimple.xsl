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
    <xsl:variable name="labelArray" select="'color', 'nature', 'shape', 'tech'"/>
    <xsl:variable name="strokeArray" select="('palegreen', 'lightblue', 'blanchedalmond', 'pink')"/>
    <xsl:variable name="line" select="10"/>
    
    <xsl:variable name="total" select="//page/*[not(self::line)][not(self::description)]! name() => count()"/>
    <xsl:variable name="labelCounter" select="//page/*[not(self::line)][not(self::description)]! name() => distinct-values() => count()"/>
    <xsl:variable name="color" select="//color => count()"/>
    <xsl:variable name="nature" select="//nature => count()"/>
    <xsl:variable name="shape" select="//shape => count()"/>
    <xsl:variable name="tech" select="//tech => count()"/>
    
    <xsl:variable as="xs:double+" name="valueArray">
        <xsl:value-of select="$color"/> 
        <xsl:value-of select="$nature"/>
        <xsl:value-of select="$shape"/>
        <xsl:value-of select="$tech"/>
    </xsl:variable>
    
    <xsl:variable as="xs:float+" name="percentArray"> 
        <xsl:for-each select="$valueArray">
            <xsl:value-of select=". div $total"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable as="xs:float+" name="radianArray">
        <xsl:for-each select="$percentArray">
            <xsl:value-of select=". * 2 * math:pi()"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable as="xs:float+" name="midArcArray">
        <xsl:for-each select="$radianArray">
            <xsl:variable name="pos" select="position()"/>

            <xsl:variable as="xs:float+" name="preceding">
                <xsl:value-of select="0"/>
                <xsl:for-each select="$radianArray[position() &lt;= $pos]">
                    <xsl:value-of select="."/>
                </xsl:for-each>
            </xsl:variable>

            <xsl:value-of select=". div 2 + sum(for $i in $preceding[position() &lt;= $pos] return ($i))"/>    
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable as="xs:float+" name="midXPos">
        <xsl:for-each select="$midArcArray">
            <xsl:value-of select="2*$radius * math:cos(.)"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable as="xs:float+" name="midYPos">
        <xsl:for-each select="$midArcArray">
            <xsl:value-of select="2*$radius  * math:sin(.)"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable as="xs:float+" name="labelXPos">
        <xsl:for-each select="$midArcArray">
            <xsl:value-of select="$labelRadius * math:cos(.)"/>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable as="xs:float+" name="labelYPos">
        <xsl:for-each select="$midArcArray">
            <xsl:value-of select="$labelRadius * math:sin(.)"/>
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

                <xsl:for-each select="1 to $labelCounter">
                    <xsl:variable name="index" select="$labelCounter + 1 -current()"/>
                    <xsl:variable name="percents" select="$percentArray[position() &lt;= $index]"/>           
                    <xsl:variable name="sumPercents">
                        <xsl:value-of select="sum(for $i in $percents[position() &lt;= $index] return number($i))"/>  
                    </xsl:variable>
                    
                    <xsl:variable name="t_labelXPos" select="$labelXPos[$index]"/>
                    <xsl:variable name="t_labelYPos" select="$labelYPos[$index]"/>
                    <xsl:variable name="t_midXPos" select="$midXPos[$index]"/>
                    <xsl:variable name="t_midYPos" select="$midYPos[$index]"/>
                    
                    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}"
                            stroke-dasharray="{$circumf * $sumPercents, $circumf}"
                            stroke="{$strokeArray[current()]}"/>
                    
                    <text x="{$t_labelXPos}" 
                        y="{$t_labelYPos}" 
                        text-anchor="{yxj:textAnchor($t_midXPos)}"
                        font-weight="bold" font-size="30">
                        <xsl:value-of select="$labelArray[$labelCounter + 1 -current()]"/>:
                        <xsl:value-of select='format-number($percents[$index]*100,"#.00")'/>%
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
            </g>
        </svg>   
    </xsl:template>
</xsl:stylesheet>