<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg">
    
    <xsl:output method="xml" indent="yes"/> 
    
    <xsl:template match="/">
        <xsl:variable name="Xinterval" select="70"/>
        <xsl:variable name="Yinterval" select="-7"/>
        <xsl:variable name="chapterCount" select="//chapter=>count()"/>
        <xsl:variable name="Xaxis" select="(//chapter=>count()+1)*$Xinterval"/>
        <xsl:variable name="maxAlice" select="/*/chapter[p[max(/*/chapter/count(p/q[@sp]))]]//q[@sp='alice']=>count()"/>
        <xsl:variable name="maxOther" select="/*/chapter[p[max(/*/chapter/count(p/q[@sp]))]]//q[@sp!='alice']=>count()"/>
        
        <xsl:variable name="maxSp" select="max(($maxAlice, $maxOther))"/>
        <xsl:variable name="Yaxis" select="$Yinterval*($maxSp+10)"/>

        <svg>
            <g transform="translate(70, 620)">
               <!-- coordinate axis -->
               <line x1="20"
                   x2="20"
                   y1="0"
                   y2="{$Yaxis}"
                   stroke="black"
                   stroke-width="1"/>
               <line x1="20"
                   x2="{$Xaxis}"
                   y1="0"
                   y2="0"
                   stroke="black"
                   stroke-width="1"/>
                
                <xsl:for-each select="0 to $maxSp + 10">
                    <xsl:if test="current() mod 10 = 0">
                        <xsl:choose>
                            <xsl:when test="current()=0"><text x="7" y="0">0</text></xsl:when>
                            <xsl:otherwise>
                                <text x="0" y="{current()*$Yinterval}">
                                    <xsl:value-of select="current()"/>
                                </text>
                                <line x1="20" y1="{current()*$Yinterval}" 
                                    x2="{$Xaxis}" y2="{current()*$Yinterval}"               
                                    stroke="lightgreen" stroke-width="2" 
                                    stroke-dasharray="10 10"></line>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:if>
                </xsl:for-each>
                
                <!-- 
               <path stroke="lightgreen" stroke-width="2" stroke-dasharray="10,10" d="M20 -70 H{(//chapter=>count()+1)*$Xinterval}"/>
               <path stroke="lightgreen" stroke-width="2" stroke-dasharray="10,10" d="M20 -140 H{(//chapter=>count()+1)*$Xinterval}"/>
                 -->
                
                <!-- labels -->
                <g transform="translate(1000,-300)" style="text-anchor:left;"> 
                   <text x="-50" y="0">Alice</text>
                   <path stroke="red" stroke-width="2" d="M0 -5 H40"></path>
                   <text x="-50" y="20">Others</text>
                   <path stroke="blue" stroke-width="2" d="M0 15 H40"></path>
               </g>
               
               
               <xsl:for-each select="//chapter">
                   <!-- variables for Alice-->
                   <xsl:variable name="Xpos" select="@which * $Xinterval"/>
                   <xsl:variable name="AliceSp" select="current()//q[@sp='alice']=>count()"/>
                   <xsl:variable name="Ypos" select="$AliceSp * $Yinterval"/>
                   <xsl:variable name="nextAliceSp" select="current()//following-sibling::chapter[1]//q[@sp='alice']=>count()"/>
                   <xsl:variable name="nextYpos" select="$nextAliceSp * $Yinterval"/>
                   
                   <!-- variables for not Alice -->
                   <xsl:variable name="otherSp" select="current()//q[@sp!='alice']=>count()"/>
                   <xsl:variable name="otherYpos" select="$otherSp * $Yinterval"/>
                   <xsl:variable name="nextOtherSp" select="current()//following-sibling::chapter[1]//q[@sp!='alice']=>count()"/>
                   <xsl:variable name="nextOtherYpos" select="$nextOtherSp * $Yinterval"/>
                   
                   <!-- green dashed lines -->
                   <line x1="{$Xpos}" y1="0" 
                       x2="{$Xpos}" y2="{$Yaxis}"               
                       stroke="lightgreen" stroke-width="2" 
                       stroke-dasharray="10 10"></line>
                   
                   <!-- lines -->
                   <xsl:if test="@which &lt; $chapterCount">
                       <!-- This line is for Alice. -->
                       <line x1="{$Xpos}" y1="{$Ypos}" 
                             x2="{$Xpos + $Xinterval}" y2="{$nextYpos}"
                             stroke="red"
                             stroke-width="2"/>
                       <!-- This line is not for Alice. -->
                       <line x1="{$Xpos}" y1="{$otherYpos}" 
                             x2="{$Xpos + $Xinterval}" y2="{$nextOtherYpos}"
                             stroke="blue"
                             stroke-width="2"/>
                       
                   </xsl:if>
                   <circle cx="{$Xpos}" cy="{$Ypos}" r="5" fill="red"/>
                   <circle cx="{$Xpos}" cy="{$otherYpos}" r="5" fill="blue"/>
                   <text x="{$Xpos}" y="30"  style="text-anchor:middle;">Ch. <xsl:value-of select="@which"/></text>
                   
                   
               </xsl:for-each>
               
           </g>
       </svg>
        
    </xsl:template>
    
</xsl:stylesheet>