<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:output method="xml" indent="yes"/> 
    
    <xsl:variable name="cx" select="0"/>
    <xsl:variable name="radius" select="150"/>
    <xsl:variable name="labelRadius" select="2*$radius + 100"/>
    <xsl:variable name="font-size" select="30"/>
    
    <!-- variable for decoration -->
    <xsl:variable name="line" select="10"/>
    
    <xsl:variable name="total" select="//page/*[not(self::line)][not(self::description)]! name() => count()"/>
    <xsl:variable name="color" select="//color => count()"/>
    <xsl:variable name="nature" select="//nature => count()"/>
    <xsl:variable name="shape" select="//shape => count()"/>
    <xsl:variable name="tech" select="//tech => count()"/>
    
    <xsl:variable name="colorPercent" select="$color div $total"/>
    <xsl:variable name="naturePercent" select="$nature div $total"/>
    <xsl:variable name="shapePercent" select="$shape div $total"/>
    <xsl:variable name="techPercent" select="$tech div $total"/>
    
    <!-- Convert percentage to angle in radians -->
    <xsl:variable name="radians" select="math:pi() div 180"/>
    <xsl:variable name="colorRadians" select="$colorPercent * 360 * $radians"/>
    <xsl:variable name="natureRadians" select="$naturePercent * 360 * $radians"/>
    <xsl:variable name="shapeRadians" select="$shapePercent * 360 * $radians"/>
    <xsl:variable name="techRadians" select="$techPercent * 360 * $radians"/>
    
    <!-- the mid of the arc in polar coordination -->
    <xsl:variable name="colorRadiansMid" select="$colorRadians div 2"/>
    <xsl:variable name="natureRadiansMid" select="$colorRadians+$natureRadians div 2"/>
    <xsl:variable name="shapeRadiansMid" select="$colorRadians+$natureRadians+$shapeRadians div 2"/>
    <xsl:variable name="techRadiansMid" select="$colorRadians+$natureRadians+$shapeRadians+$techRadians div 2"/>
    
    <!-- the mid of the arc in rectangular coordination -->
    <xsl:variable name="colorMidX" select="2*$radius* math:cos($colorRadiansMid)"/>
    <xsl:variable name="colorMidY" select="2*$radius* math:sin($colorRadiansMid)"/>
    <xsl:variable name="natureMidX" select="2*$radius* math:cos($natureRadiansMid)"/>
    <xsl:variable name="natureMidY" select="2*$radius* math:sin($natureRadiansMid)"/>
    <xsl:variable name="shapeMidX" select="2*$radius* math:cos($shapeRadiansMid)"/>
    <xsl:variable name="shapeMidY" select="2*$radius* math:sin($shapeRadiansMid)"/>
    <xsl:variable name="techMidX" select="2*$radius* math:cos($techRadiansMid)"/>
    <xsl:variable name="techMidY" select="2*$radius* math:sin($techRadiansMid)"/>
    
    <!-- position of texts in rectangular coordination-->
    <xsl:variable name="colorX" select="$labelRadius* math:cos($colorRadiansMid)"/>
    <xsl:variable name="colorY" select="$labelRadius* math:sin($colorRadiansMid)"/>
    <xsl:variable name="natureX" select="$labelRadius* math:cos($natureRadiansMid)"/>
    <xsl:variable name="natureY" select="$labelRadius* math:sin($natureRadiansMid)"/>
    <xsl:variable name="shapeX" select="$labelRadius* math:cos($shapeRadiansMid)"/>
    <xsl:variable name="shapeY" select="$labelRadius* math:sin($shapeRadiansMid)"/>
    <xsl:variable name="techX" select="$labelRadius* math:cos($techRadiansMid)"/>
    <xsl:variable name="techY" select="$labelRadius* math:sin($techRadiansMid)"/>
    
    <!-- pie chart -->
    <xsl:template match="/">
        <svg width="600px" viewBox="-100 100 1200 800">
            <g transform="translate(500, 500)">
                <xsl:variable name="circumf" select="2 * math:pi() * $radius"/>
                <circle fill="none" cx="{$cx}" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($colorPercent  + $naturePercent  +  $shapePercent  + $techPercent), $circumf}" stroke="palegreen"/>
                
                <circle fill="none" cx="{$cx}" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($colorPercent + $naturePercent + $shapePercent), $circumf}" stroke="lightblue"/>
                
                <circle fill="none" cx="{$cx}" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($colorPercent + $naturePercent), $circumf}" stroke="blanchedalmond"/>
                
                <circle fill="none" cx="{$cx}" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * $colorPercent, $circumf}" stroke="pink"/>
                
            </g>
            
            <!-- Set the text anchor for labels -->
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
            

            
            <!-- Set the decoration line for lables -->
            <xsl:variable name="colorLine">
                <xsl:choose><xsl:when test="$colorX &lt; $cx"> -<xsl:value-of select="$line"/></xsl:when> 
                    <xsl:otherwise>+<xsl:value-of select="$line"/></xsl:otherwise>
                </xsl:choose>     
            </xsl:variable>
            
            <xsl:variable name="natureLine">
                <xsl:choose><xsl:when test="$natureX &lt; $cx"> -<xsl:value-of select="$line"/></xsl:when> 
                    <xsl:otherwise>+<xsl:value-of select="$line"/><xsl:value-of select="$line"/></xsl:otherwise>
                </xsl:choose>     
            </xsl:variable>
            
            <xsl:variable name="shapeLine">
                <xsl:choose><xsl:when test="$shapeX &lt; $cx"> -<xsl:value-of select="$line"/></xsl:when> 
                    <xsl:otherwise>+<xsl:value-of select="$line"/></xsl:otherwise>
                </xsl:choose>     
            </xsl:variable>
            
            <xsl:variable name="techLine">
                <xsl:choose><xsl:when test="$techX &lt; $cx"> -<xsl:value-of select="$line"/></xsl:when> 
                    <xsl:otherwise>+<xsl:value-of select="$line"/></xsl:otherwise>
                </xsl:choose>     
            </xsl:variable>
            
            <!-- Labels -->
            <g transform="translate(500, 500)" fill="black" font-weight="bold" font-size="{$font-size}" >
                <text x="{$colorX}" y="{$colorY}" text-anchor="{$colorTextAnchor}">
                 color: 
                <xsl:value-of select='format-number($colorPercent*100,"#.00")'/>%
                </text>
                <text x="{$natureX}" y="{$natureY}" text-anchor="{$natureTextAnchor}">
                    nature: 
                    <xsl:value-of select='format-number($naturePercent*100,"#.00")'/>%
                </text>
                <text x="{$shapeX}" y="{$shapeY}" text-anchor="{$shapeTextAnchor}">
                    shape: 
                    <xsl:value-of select='format-number($shapePercent*100,"#.00")'/>%
                </text>
                <text x="{$techX}" y="{$techY}" text-anchor="{$techTextAnchor}">
                    tech: 
                    <xsl:value-of select='format-number($techPercent*100,"#.00")'/>%
                </text>
            </g>
            
            <!-- label lines -->
            <g transform="translate(500, 500)" stroke="grey" stroke-width="3" fill="none">              
                <path d="M{$colorMidX} {$colorMidY} L{$colorMidX+$colorLine} {$colorY+10 -$font-size div 2} H{$colorX -$colorLine}"/>
                <circle cx="{$colorX -$colorLine}" cy="{$colorY+10 -$font-size div 2}" r="4" fill="grey"/>
                <path d="M{$natureMidX} {$natureMidY} L{$natureMidX+$natureLine} {$natureY+10 -$font-size div 2} H{$natureX -$natureLine}"/>
                <circle cx="{$natureX -$natureLine}" cy="{$natureY+10 -$font-size div 2}" r="4" fill="grey"/>
                <path d="M{$shapeMidX} {$shapeMidY} L{$shapeMidX+$shapeLine} {$shapeY+10 -$font-size div 2} H{$shapeX -$shapeLine}"/>
                <circle cx="{$shapeX -$shapeLine}" cy="{$shapeY+10 -$font-size div 2}" r="4" fill="grey"/>
                <path d="M{$techMidX} {$techMidY} L{$techMidX+$techLine} {$techY+10 -$font-size div 2} H{$techX -$techLine}"/>
                <circle cx="{$techX -$techLine}" cy="{$techY+10 -$font-size div 2}" r="4" fill="grey"/>
            </g>
        </svg>
    </xsl:template> 
</xsl:stylesheet>