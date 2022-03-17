<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math">
    
    <xsl:output method="xml" indent="yes"/> 
    
    <xsl:variable name="total" select="//page/*[not(self::line)][not(self::description)]! name() => count()"/>
    
    <xsl:variable name="radius" select="200"/>
    
    <xsl:variable name="color" select="//color => count()"/>
    <xsl:variable name="nature" select="//nature => count()"/>
    <xsl:variable name="shape" select="//shape => count()"/>
    <xsl:variable name="tech" select="//tech => count()"/>
    
    <xsl:variable name="colorPercent" select="$color div $total"/>
    <xsl:variable name="naturePercent" select="$nature div $total"/>
    <xsl:variable name="shapePercent" select="$shape div $total"/>
    <xsl:variable name="techPercent" select="$tech div $total"/>
    

    <xsl:template match="/">
        <svg viewBox="-10 -10 1000 1000">
            <g transform="translate(500, 500)">
                <xsl:variable name="circumf" select="2 * math:pi() * $radius"/>
                <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($techPercent  + $colorPercent  +  $naturePercent  + $shapePercent), $circumf}" stroke="palegreen"/>
                
                <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf *  ($techPercent + $colorPercent + $naturePercent), $circumf}" stroke="lightblue"/>
                
                <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($techPercent + $colorPercent), $circumf}" stroke="blanchedalmond"/>
                
                <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * $techPercent, $circumf}" stroke="pink"/>
                
            </g>
            
            
            <g transform="translate(500, 500)" fill="black" font-weight="bold" font-size="30">
                <text x="{-20}" y="{240}">
                 color: 
                <xsl:value-of select='format-number($colorPercent*100,"#.00")'/>%
                </text>
                <text x="{-180}" y="{-140}">
                    nature: 
                    <xsl:value-of select='format-number($naturePercent*100,"#.00")'/>%
                </text>
                <text x="{180}" y="{-40}">
                    shape: 
                    <xsl:value-of select='format-number($shapePercent*100,"#.00")'/>%
                </text>
                <text x="{190}" y="{60}">
                    tech: 
                    <xsl:value-of select='format-number($techPercent*100,"#.00")'/>%
                </text>
            </g>
            
        </svg>
    </xsl:template> 
</xsl:stylesheet>