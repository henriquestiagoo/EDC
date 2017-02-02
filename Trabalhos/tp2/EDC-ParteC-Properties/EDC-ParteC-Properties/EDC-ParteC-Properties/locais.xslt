<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="cursos">
    <Locais>
      <xsl:for-each select="curso">
        <local>
          <xsl:attribute name="nome">
            <xsl:value-of select="local"/>
          </xsl:attribute>
        </local>
      </xsl:for-each>
    </Locais>
  </xsl:template>
</xsl:stylesheet>