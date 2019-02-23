<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <head>
        <link type="text/css" rel="stylesheet" href="biblioteka.css"/>
      </head>
      <body>
        <table>
          <tr>
            <td colspan="10" align="center" style="font-weight: bold;
  font-size: large; background-color: rgb(120, 90, 80); color: rgb(250, 250, 250)"> BIBLIOTEKA </td>
          </tr>
          <xsl:for-each select="biblioteka/dzialy/dzial">
            <xsl:sort select="@nazwaDzialu"/>
            <tr>
              <td colspan="10" class="TytulyDzialow">
                <xsl:value-of select="@nazwaDzialu"/>
              </td>
            </tr>
            <tr>
              <td style="font-style: italic"> Nr </td>
              <td> Autor </td>
              <td> Tytuł </td>
              <td> Cena </td>
            </tr>
            <xsl:for-each select="ksiazka">
              <xsl:sort select="autor/nazwisko"/>
              <tr>
                <td>
                  <xsl:number value="position()"/>
                </td>
                <td>
                  <xsl:value-of select="autor"/>
                </td>
                <td>
                  <xsl:value-of select="tytul"/>
                </td>
                <td>
                  <xsl:value-of select="cenaC"/>
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
