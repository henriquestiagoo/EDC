<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
    <owners>
      <xsl:for-each select="//owner">
        <owner>
          <xsl:attribute name="tax_id">
            <xsl:value-of select="tax_id/text()"/>
          </xsl:attribute>
          <xsl:attribute name="name">
            <xsl:value-of select="name/text()"/>
          </xsl:attribute>
          <xsl:attribute name="date">
            <xsl:value-of select="date/text()"/>
          </xsl:attribute>
          <xsl:attribute name="property_id">
            <xsl:value-of select="../@id"/>
          </xsl:attribute>
        </owner>
      </xsl:for-each>
    </owners>
  </xsl:template>
</xsl:stylesheet>