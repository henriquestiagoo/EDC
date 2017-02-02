<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    xmlns:cin="http://services.sapo.pt/Metadata/Cinema"
    xmlns:gis="http://services.sapo.pt/Metadata/GIS"
    xmlns:i="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="msxsl gis cin i"
>
  <xsl:output method="xml"
    omit-xml-declaration="yes"
    indent="yes"
    standalone="yes" />
  <xsl:template match="/">
    <Movies>
      <xsl:for-each select="//cin:Movie">
        <!--Ordenar por data -->
        <xsl:sort select="cin:Year"/>
        <xsl:element name="Movie">
          <xsl:attribute name="Id">
            <xsl:variable name="input" select="cin:Id" />
            <xsl:value-of select="translate($input,' &#xA; ', '')"/>
          </xsl:attribute>

          <xsl:attribute name="PTName">
            <xsl:variable name="input" select="cin:Release/cin:Title" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="ENName">
            <xsl:variable name="input" select="cin:Title" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Genre">
            <xsl:variable name="input" select="cin:Genres/cin:Genre/cin:Name" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Rating">
            <xsl:variable name="input" select="cin:Release/cin:Rating/cin:Name" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="ProductionCountry">
            <xsl:variable name="input" select="cin:ProductionCountries/cin:Country/gis:CountryName" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Year">
            <xsl:variable name="input" select="cin:Year" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="OfficialURL">
            <xsl:variable name="input" select="cin:References/cin:Links/cin:Link/cin:URL" />
            <xsl:value-of select="translate($input,' &#xA; ', '')"/>
          </xsl:attribute>


          <xsl:attribute name="BigImage">
            <xsl:variable name="input" select="cin:Media/cin:MediaItem[1]/cin:Thumbnails/cin:Thumbnail[cin:Name='thumb_234x341']/cin:URL" />
            <xsl:value-of select="translate($input,' &#xA; ', '')"/>
          </xsl:attribute>

          <xsl:attribute name="SmallImage">
            <xsl:variable name="input" select="cin:Media/cin:MediaItem[1]/cin:Thumbnails/cin:Thumbnail[cin:Name='thumb_120x120']/cin:URL" />
            <xsl:value-of select="translate($input,' &#xA; ', '')"/>
          </xsl:attribute>

          <!-- Role = 21 -> Ator -->
          <xsl:attribute name="Actors">
            <xsl:for-each select="cin:Contributors/cin:Contributor">
              <xsl:for-each select="cin:Role[cin:Id='21']">
                <xsl:for-each select="../cin:Person">
                  <xsl:variable name="input" select="cin:Name" />
                  <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
                  <xsl:value-of select="'; '"/>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:attribute>

          <!-- Role = 2 -> Diretor-->
          <xsl:attribute name="Directors">
            <xsl:for-each select="cin:Contributors/cin:Contributor">
              <xsl:for-each select="cin:Role[cin:Id='2']">
                <xsl:for-each select="../cin:Person">
                  <xsl:variable name="input" select="cin:Name" />
                  <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
                  <xsl:value-of select="'; '"/>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:attribute>

          <!-- Role = 3 -> Argumentista -->
          <xsl:attribute name="Argument">
            <xsl:for-each select="cin:Contributors/cin:Contributor">
              <xsl:for-each select="cin:Role[cin:Id='3']">
                <xsl:for-each select="../cin:Person">
                  <xsl:variable name="input" select="cin:Name" />
                  <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
                  <xsl:value-of select="'; '"/>
                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>

          </xsl:attribute>
          <xsl:attribute name="Synopsis">
            <xsl:variable name="input" select="cin:Synopsis" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

          <xsl:attribute name="Distributor">
            <xsl:variable name="input" select="cin:Release/cin:Distributor" />
            <xsl:value-of select="normalize-space(translate($input,'&#xA;', ''))"/>
          </xsl:attribute>

        </xsl:element>
      </xsl:for-each>
    </Movies>
  </xsl:template>
</xsl:stylesheet>