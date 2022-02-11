<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  xmlns="http://www.w3.org/2000/svg">
  
  <xsl:output method="xml" indent="yes"/>
  <!-- COLLECTION VARIABLE: -->
  <xsl:variable name="KG" select="collection('xml/?select=*.xml')"/>
  
  <xsl:template match="/">
    <!-- variables -->
    <xsl:variable name="pageCount" select="$KG//page=>count()"/>
    <xsl:variable name="x-spacer" select="60"/>
    <xsl:variable name="y-spacer" select="-3"/>
    <svg>
      <g transform="translate(0, 550)">
        <!-- x-aixs -->
        <line x1="0" y1="0" x2="{$pageCount*$x-spacer}" y2="0" stroke="black" stroke-width="2"/>
        
      <xsl:for-each select="$KG//page[@n ! number() gt 3]">
        <g class="page" id="{@n}">
          <!-- local variable 
          a count of colors
          -->
          <xsl:variable name="colorCount" select="current()//color => count()"/>
          <xsl:variable name="natureCount" select="current()//nature => count()"/>
          <xsl:variable name="techCount" select="current()//tech => count()"/>
          <xsl:variable name="shapeCount" select="current()//shape => count()"/>
          <xsl:variable name="totalCount" select="$colorCount+$natureCount+$techCount+$shapeCount"/>
          <!-- percentages -->
          <xsl:variable name="colorPerc" select="$colorCount div $totalCount*100"/>
          <xsl:variable name="naturePerc" select="$natureCount div $totalCount*100"/>
          <xsl:variable name="techPerc" select="$techCount div $totalCount*100"/>
          <xsl:variable name="shapePerc" select="$shapeCount div $totalCount*100"/>
          
          <xsl:variable name="pageNum" select="@n"/>
          <text x="{position()*$x-spacer}" y="30" transform="rotate(-20 {position()*$x-spacer},100)">
            page#<xsl:value-of select="$pageNum"/>           
          </text>
          <line class="color" x1="{position()*$x-spacer}" y1="0" x2="{position()*$x-spacer}" y2="{$colorPerc*$y-spacer}" stroke="red" stroke-width="20"/>
          <line class="nature" x1="{position()*$x-spacer}" y1="{$colorPerc*$y-spacer}" x2="{position()*$x-spacer}" y2="{($naturePerc+$colorPerc)*$y-spacer}" stroke="green" stroke-width="20"/>
          <line class="tech" x1="{position()*$x-spacer}" y1="{($naturePerc+$colorPerc)*$y-spacer}" x2="{position()*$x-spacer}" y2="{($naturePerc+$colorPerc+$techPerc)*$y-spacer}" stroke="yellow" stroke-width="20"/>
          <line class="shape" x1="{position()*$x-spacer}" y1="{($naturePerc+$colorPerc+$techPerc)*$y-spacer}" x2="{position()*$x-spacer}" y2="{($naturePerc+$colorPerc+$techPerc+$shapePerc)*$y-spacer}" stroke="blue" stroke-width="20"/>
          
          
          
        </g>
      </xsl:for-each>  
        
        
      </g>
      
    </svg>
  </xsl:template>

</xsl:stylesheet>