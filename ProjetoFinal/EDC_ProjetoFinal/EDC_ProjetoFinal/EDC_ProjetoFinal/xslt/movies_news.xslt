<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
    xmlns:atom="http://www.w3.org/2005/Atom"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:element name ="rss">
      <xsl:for-each select="//item">
        <xsl:element name="item">
          <xsl:attribute name="title">
            <xsl:value-of select="title"/>
          </xsl:attribute>
          <xsl:attribute name="enclosure">
            <xsl:value-of select="enclosure[./@url != 'null']/@url"/>
          </xsl:attribute>     
          <xsl:attribute name="link">
            <xsl:value-of select="link"/>
          </xsl:attribute>
          <xsl:attribute name="description">
            <xsl:value-of select="description"/>
          </xsl:attribute>
          <xsl:attribute name="pubDate">
            <xsl:value-of select="pubDate"/>
          </xsl:attribute>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
