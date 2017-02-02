<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <NewDataSet>
      <xsl:for-each select="//Table">
        <!--Ordenar por data -->
        <xsl:sort select="Year"/>
        <xsl:element name="Movie">
          <xsl:attribute name="Id">
            <xsl:variable name="input" select="Id" />
            <xsl:value-of select="translate($input,' &#xA; ', '')"/>
          </xsl:attribute>

          <xsl:attribute name="PTName">
            <xsl:variable name="input" select="PTName" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="ENName">
            <xsl:variable name="input" select="ENName" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Genre">
            <xsl:variable name="input" select="Genre" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Rating">
            <xsl:variable name="input" select="Rating" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="ProductionCountry">
            <xsl:variable name="input" select="ProductionCountry" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Year">
            <xsl:variable name="input" select="Year" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="OfficialURL">
            <xsl:variable name="input" select="OfficialURL" />
            <xsl:value-of select="translate($input,' &#xA; ', '')"/>
          </xsl:attribute>

          <xsl:attribute name="BigImage">
            <xsl:variable name="input" select="BigImage" />
            <xsl:value-of select="translate($input,' &#xA; ', '')"/>
          </xsl:attribute>

          <xsl:attribute name="SmallImage">
            <xsl:variable name="input" select="SmallImage" />
            <xsl:value-of select="translate($input,' &#xA; ', '')"/>
          </xsl:attribute>

          <xsl:attribute name="Actors">
            <xsl:variable name="input" select="Actors" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Directors">
            <xsl:variable name="input" select="Directors" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Argument">
            <xsl:variable name="input" select="Argument" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>
          
          <xsl:attribute name="Synopsis">
            <xsl:variable name="input" select="Synopsis" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Distributor">
            <xsl:variable name="input" select="Distributor" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

        </xsl:element>
      </xsl:for-each>
    </NewDataSet>
  </xsl:template>
  
</xsl:stylesheet>
