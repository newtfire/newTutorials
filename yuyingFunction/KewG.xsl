<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="3.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:yxj="http://www.yxj5181.com">
  
  <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
    include-content-type="no" indent="yes"/>
  
  <xsl:variable name="KG" select="collection('?select=KewG_p4-12.xml')"/>
  <xsl:variable name="types" select="$KG//page/*[not(self::line)][not(self::description)]! name() => distinct-values() => sort()"/>

  <xsl:function name="yxj:reformat" as="xs:string+">
    <xsl:param name="node" as="node()+"/>
    <xsl:sequence select="$node!lower-case(.)!normalize-space()!replace(.,'[- ]','')!replace(.,'ves','f')!replace(.,'shaped','')!replace(.,'ies','y')"/>
  </xsl:function>
  
  <xsl:function name="yxj:tableMaker">
    <xsl:for-each select="$types">
      <table>
        <tr>
          <th><xsl:value-of select="current()"/></th>
          <th><xsl:text>count</xsl:text></th>
        </tr> 
        <xsl:for-each select="yxj:reformat($KG//page/*[./name()=current()])=>distinct-values()">
          <xsl:sort select="count($KG//*[yxj:reformat(.) =current()])" order="descending"/>
          <tr>
            <td>
              <xsl:value-of select="string-join($KG//page/*[yxj:reformat(.)=current()] => distinct-values(), ', ')"/>
            </td>
            <td>
              <xsl:value-of select="count($KG//*[yxj:reformat(.)=current()])"/>
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
        <xsl:sequence select="yxj:tableMaker()"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
