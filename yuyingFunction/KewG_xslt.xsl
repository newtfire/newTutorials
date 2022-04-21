<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="3.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:yxj="http://www.yxj5181.com">
  
  <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
    include-content-type="no" indent="yes"/>
  
  <xsl:variable name="strings" select="//page/*[not(self::line)][not(self::description)]! name() => distinct-values() => sort()"/>
  
  <xsl:function name="yxj:reformat" as="xs:string+">
    <xsl:param name="node" as="node()"/>
    <xsl:sequence select="$node!lower-case(.)! normalize-space()!replace(.,'[- ]','')!replace(.,'ves','f')!replace(.,'shaped','')!replace(.,'ies','y')"/>
  </xsl:function>
  
  <xsl:function name="yxj:tableMaker" as="node()">
    <xsl:for-each select="$strings">
      <table>
        <tr>
          <th><xsl:value-of select="current()"/></th>
          <th><xsl:text>count</xsl:text></th>
        </tr> 
        <xsl:variable name="valuesList" as="xs:string+" select="yxj:reformat(//page/*[name() = current()]//*) => distinct-values()"/>
        <xsl:for-each select="$valuesList">
          <xsl:sort select="yxj:reformat(current()) = current()])" order="descending"/>
          <tr>
            <td>
              <xsl:value-of select="string-join(//page/*[yxj:reformat(.) = current()] => distinct-values(), ', ')"/>
            </td>
            <td>
              <xsl:value-of select="count(//*[yxj:reformat(.) = current()])"/>
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
            <xsl:for-each select="$strings">
            <th>
              <span class="{current()}"><xsl:value-of select="current()"/></span>
            </th>
            </xsl:for-each>
          </tr>
          <tr>
            <xsl:for-each select="$strings">
            <td>
              <xsl:value-of select="count(//*[.!name()=current()])"/>
            </td>
            </xsl:for-each>
          </tr>
        </table>
        <xsl:sequence select="yxj:tableMaker()"/>
        <xsl:apply-templates select="(//xml/metadata)[2]"/>
        <xsl:apply-templates select="//xml//page"/>
      </body>
    </html>
    </xsl:template>
</xsl:stylesheet>
