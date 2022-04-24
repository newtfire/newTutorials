<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <!--    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
              exclude-result-prefixes="xs math"-->
    
    
    <xsl:variable name="radius" select="20"/>
        <!-- math:pi() returns the value of pi-->    
        <xsl:variable name="circumf" select="2 * math:pi() * $radius"/>
        
        
    <!-- This is an example to draw a pie chart in XSLT -->
    <xsl:variable name="colorPercent" select="$color div $total"/>
    <xsl:variable name="naturePercent" select="$nature div $total"/>
    <xsl:variable name="shapePercent" select="$shape div $total"/>
    <xsl:variable name="techPercent" select="$tech div $total"/>
    
    <xsl:variable name="circumf" select="2 * math:pi() * $radius"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" 
        stroke-width="{$radius * 2}" stroke-dasharray="{$circumf * ($techPercent  + $colorPercent  +  $naturePercent  + $shapePercent), $circumf}" stroke="palegreen"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}"
        stroke-dasharray="{$circumf *  ($techPercent + $colorPercent + $naturePercent), $circumf}" stroke="lightblue"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" 
        stroke-dasharray="{$circumf * ($techPercent + $colorPercent), $circumf}" stroke="blanchedalmond"/>
    
    <circle fill="none" cx="0" cy="0" r="{$radius}" stroke-width="{$radius * 2}" 
        stroke-dasharray="{$circumf * $techPercent, $circumf}" stroke="pink"/>
    
</xsl:stylesheet>