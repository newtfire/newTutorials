<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:output method="xml" indent="yes"/> 
    
    <xsl:variable name="KG" select="collection('xml/?select=*.xml')"/>
    <xsl:variable name="total" select="$KG//page/*[not(self::line)][not(self::description)]! name() => count()"/>
    
    <xsl:variable name="radius" select="200"/>
    
    <xsl:variable name="color" select="$KG//page/color => count()"/>
    <xsl:variable name="nature" select="$KG//page/nature => count()"/>
    <xsl:variable name="shape" select="$KG//page/shape => count()"/>
    <xsl:variable name="tech" select="$KG//page/tech => count()"/>
    
    <xsl:variable name="colorPercent" select="$color div $total"/>
    <xsl:variable name="naturePercent" select="$nature div $total"/>
    <xsl:variable name="shapePercent" select="$shape div $total"/>
    <xsl:variable name="techPercent" select="$tech div $total"/>
    
    <xsl:variable name="colorAngle" select="360 * $colorPercent"/>
    <xsl:variable name="natureAngle" select="$colorAngle+ 360 * $naturePercent"/>
    <xsl:variable name="shapeAngle" select="$natureAngle+360 * $shapePercent"/>
    <xsl:variable name="techAngle" select="$shapeAngle+360 * $techPercent"/>
    
    <xsl:variable name="colorRatio" select="2 * $colorPercent"/>
    <xsl:variable name="natureRatio" select="2 * $naturePercent"/>
    <xsl:variable name="shapeRatio" select="2 * $shapePercent"/>
    <xsl:variable name="techRatio" select="2 * $techPercent"/>
    
    <!--coordX = radius * math:cos( math:pi() * angle div 180 )
        coordY = radius * math:sin( math:pi() * angle div 180 )-->
    
    <xsl:variable name="colorX" select="$radius * math:cos(math:pi() * $colorAngle div 180)"/>
    <xsl:variable name="colorY" select="$radius * math:sin(math:pi() * $colorAngle div 180)"/>
    
    <xsl:variable name="natureX" select="$radius * math:cos(math:pi() * $natureAngle div 180)"/>
    <xsl:variable name="natureY" select="$radius * math:sin(math:pi() * $natureAngle div 180)"/>
    
    <xsl:variable name="shapeX" select="$radius * math:cos(math:pi() * $shapeAngle div 180)"/>
    <xsl:variable name="shapeY" select="$radius * math:sin(math:pi() * $shapeAngle div 180)"/>
    
    <xsl:variable name="techX" select="$radius * math:cos(math:pi() * $techAngle div 180)"/>
    <xsl:variable name="techY" select="$radius * math:sin(math:pi() * $techAngle div 180)"/>
    
    
    <xsl:variable name="colorFlag">
        <xsl:choose><xsl:when test="$colorRatio lt 1">0</xsl:when> 
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>
    
    <xsl:variable name="natureFlag">
        <xsl:choose><xsl:when test="$natureRatio lt 1">0</xsl:when> 
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>
    
    <xsl:variable name="shapeFlag">
        <xsl:choose><xsl:when test="$shapeRatio lt 1">0</xsl:when> 
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>
    
    <xsl:variable name="techFlag">
        <xsl:choose><xsl:when test="$techRatio lt 1">0</xsl:when> 
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>     
    </xsl:variable>
    
    
    
    <xsl:template match="/">
        <svg>
            <g transform="translate(500, 500)">
                <xsl:variable name="circumf" select="2 * math:pi() * $radius"/>
                <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($techPercent  + $colorPercent  +  $naturePercent  + $shapePercent), $circumf}" stroke="orange"/>
                <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($techPercent + $colorPercent + $naturePercent), $circumf}" stroke="yellow"/>
                
            <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($techPercent + $colorPercent), $circumf}" stroke="pink"/>
                <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * $techPercent, $circumf}" stroke="blue"/>
                
            
              
                -->
                
            </g>
            
            
         <!--   <g transform="translate(250, 250)">
                
               <path d="M0,0 L{$radius},0 A{$radius},{$radius} 0 {$colorFlag},1
                        {$colorX},{$colorY} Z"
                    style="stroke: red; stroke-width:2; fill:red;"/>
                <path d="M0,0 L{$colorX},{$colorY} A{$radius},{$radius} 0 {$natureFlag},1 
                    {$natureX},{$natureY} Z"
                    style="stroke: green; stroke-width:2; fill:green;"/>
                
                <path d="M0,0 L{$natureX},{$natureY} A{$radius},{$radius} 0 {$shapeFlag},1 
                    {$shapeX},{$shapeY} Z"
                    style="stroke:gold; stroke-width:2; fill:gold;"/>
                
                <path d="M0,0 L{$shapeX},{$shapeY} A{$radius},{$radius} 0 {$techFlag},1 
                    {$techX},{$techY} Z"
                    style="stroke: blue; stroke-width:2; fill:blue;"/>
                
                
                <g fill="white" font-weight="bold"><text x="{$colorX + 100}" y="{$colorY - 100}">
                    <xsl:value-of select='format-number($colorPercent*100,"#.00")'/>%
                </text>
                <text x="{$natureX -300}" y="{$natureY +150}">
                    <xsl:value-of select='format-number($naturePercent*100,"#.00")'/>%
                </text>
                <text x="{$shapeX -60}" y="{$shapeY -10}">
                    <xsl:value-of select='format-number($shapePercent*100,"#.00")'/>%
                </text>
                <text x="{$techX -60}" y="{$techY - 30}">
                    <xsl:value-of select='format-number($techPercent*100,"#.00")'/>%
                </text></g>
                
            </g>-->
        </svg>
    </xsl:template> 
</xsl:stylesheet>