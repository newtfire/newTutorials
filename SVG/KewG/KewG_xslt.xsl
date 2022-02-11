<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:yxj="http://www.yxj5181.com"
  version="3.0"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
    include-content-type="no" indent="yes"/>
  
  <xsl:variable name="KG" select="collection('xml/?select=*.xml')"/>
  <xsl:variable name="elements" select="$KG//page/*[not(self::line)][not(self::description)]! name() => distinct-values() => sort()"/>

  <xsl:variable name="colors" select="$KG//page/color ! normalize-space() => distinct-values()"/>
  <xsl:function name="yxj:tableMaker">
    <xsl:for-each select="$elements">
      <table>
        <tr>
          <th><xsl:value-of select="current()"/></th>
          <th><xsl:text>count</xsl:text></th>
        </tr> 
        <xsl:for-each select="$KG//page/*[./name()=current()]!lower-case(.)! normalize-space()!replace(.,'[- ]','')!replace(.,'ves','f')!replace(.,'shaped','')!replace(.,'ies','y')=>distinct-values()">
          <xsl:sort select="count($KG//*[.!lower-case(.)! normalize-space()!replace(.,'[- ]','')!replace(.,'ves','f')!replace(.,'shaped','')!replace(.,'ies','y')=current()])" order="descending"/>
          
          <tr>
            <td>
              <xsl:value-of select="string-join($KG//page/*[.!lower-case(.)! normalize-space()!replace(.,'[- ]','')!replace(.,'ves','f')!replace(.,'shaped','')!replace(.,'ies','y')=current()] => distinct-values(), ', ')"/>
            </td>
            <td>
              <xsl:value-of select="count($KG//*[.!lower-case(.)! normalize-space()!replace(.,'[- ]','')!replace(.,'ves','f')!replace(.,'shaped','')!replace(.,'ies','y')=current()])"/>
              <!-- <xsl:value-of select="count($KG//*[.!lower-case(.)!substring(.,1,3)=current()!substring(.,1,3)])"/> -->
            </td>
          </tr>
          
        </xsl:for-each>
      </table>
      
    </xsl:for-each>
  </xsl:function>
  <xsl:template match="/">
    

    <html>
      <head>
        <title>Kew Garden</title>
        <link rel="stylesheet" type="text/css" href="webstyle.css" />
      </head>
      <body>
        <table>
          <tr>
            <xsl:for-each select="$elements">
            <th>
              <span class="{current()}"><xsl:value-of select="current()"/></span>
            </th>
            </xsl:for-each>
          </tr>
          <tr>
            <xsl:for-each select="$elements">
            <td>
              <xsl:value-of select="count($KG//*[.!name()=current()])"/>
            </td>
            </xsl:for-each>
          </tr>
        </table>
        <xsl:sequence select="yxj:tableMaker()"/>
        <xsl:apply-templates select="($KG//xml/metadata)[2]"/>
        <xsl:apply-templates select="$KG//xml//page"/>
      </body>
    </html>
    </xsl:template>
  
  <xsl:template match="metadata">
    <h1><xsl:apply-templates select="descendant::title"/></h1>
    <div class="source">
      <xsl:apply-templates select="child::source"/>
    </div>
    <br/>
    <div class="edition">
      <xsl:apply-templates select="child::edition"/>
    </div>
  </xsl:template>
    
  <xsl:template match="source">
    <h2><xsl:value-of select="name()"/></h2>
    <ul><xsl:for-each select="*[not(self::title)and not(self::sourceLink)]">
      <li><xsl:value-of select="name()"/>: <xsl:value-of select="current()"/></li>
    </xsl:for-each> 
      <li><xsl:value-of select="sourceLink ! name()"/>: 
        <xsl:apply-templates select="sourceLink"/>
      </li>
    </ul>
  </xsl:template>
  
  <xsl:template match="edition">
    <h2><xsl:value-of select="name()"/></h2>
    <ul><xsl:for-each select="*">
      <li><xsl:value-of select="local-name()"/>: <xsl:value-of select="@xml:id" />
        <xsl:value-of select="."/>
      </li>
    </xsl:for-each> </ul>
    <br/>
  </xsl:template>
  
  <xsl:template match="sourceLink">
    <a href="{current()}">
      Kew Gardens by Virginia Woolf, 1927
    </a>
  </xsl:template>

  <xsl:template match="page">
    <div class="page" id="page-{@n}">
    <div class="desc">
      <small><xsl:value-of select="@n"/></small>
      <xsl:apply-templates select="description" mode = "move"/>
    </div>
      
    <div class="vwoolf">
      <span class="pageNum"><xsl:value-of select="@n"/></span>
      <xsl:apply-templates/>
    </div>
    </div>
  </xsl:template>
  
  <xsl:template match="line">
    <br class="line" id="pg-{ancestor::page/@n}-line-{@n}"/>
    <!-- <xsl:apply-templates select="following-sibling::node()"/> -->
  </xsl:template>
  
  <xsl:template match="description" mode="move">
    <span class="desc"><i><xsl:apply-templates/>——
      <xsl:value-of select="@resp"/></i></span>
  </xsl:template>
  
  <xsl:template match="description"/>
  

  <xsl:template match="nature">
    <span class="nature">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="tech">
    <span class="tech">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="color">
    <span class="color">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="shape">
    <span class="shape">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>
