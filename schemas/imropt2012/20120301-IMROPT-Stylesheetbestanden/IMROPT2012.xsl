<?xml version="1.0" encoding="UTF-8"?>

<!-- 
// Voorbeeld XSL StyleSheet IMRO2012
-->

<xsl:stylesheet version="1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" 
                              xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                              xmlns:xl="http://www.w3.org/1999/xlink"
                              xmlns:imropt="http://www.geonovum.nl/imro/pt/2012/1.0">

   <xsl:output method="html" version="1.0" indent="yes" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>
   
   <xsl:template match="/">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
         <head>
            <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
            <title><xsl:value-of select="//imropt:FeatureCollectionIMROPT/imropt:TekstMetadata/imropt:naam" /></title>
            <link rel="stylesheet" type="text/css" href="IMROPT2012.css" />
            <link rel="stylesheet" type="text/css" href="IMROPT2012print.css" media="print" />
         </head>
         <body>
            <div id="container">
               <!-- Begin -->
               <div id="begin" class="begin"></div>
               
               <!-- Koptekst -->
               <div id="koptekst" class="koptekst">
                                   
                  <!-- Planeigenschappen (metadata) -->
                  <div id="plangegevens" class="plangegevens">
                     <table class="metadata">
                        <tr><td><strong>Type plan:</strong></td><td><xsl:value-of select="imropt:FeatureCollectionIMROPT/imropt:TekstMetadata/imropt:typePlan" /></td></tr>
                        <tr><td><strong>Overheid:</strong></td><td><xsl:value-of select="imropt:FeatureCollectionIMROPT/imropt:TekstMetadata/imropt:beleidsmatigVerantwoordelijkeOverheid" />: <xsl:value-of select="imropt:FeatureCollectionIMROPT/imropt:TekstMetadata/imropt:naamOverheid" /></td></tr>
                        <tr><td><strong>Plangebied:</strong></td><td><xsl:value-of select="imropt:FeatureCollectionIMROPT/imropt:TekstMetadata/imropt:verwijzingNaarPlangebied" /></td></tr>
                        <tr><td><strong>Gemaakt op:</strong></td><td><xsl:value-of select="imropt:FeatureCollectionIMROPT/imropt:TekstMetadata/imropt:creatiedatum" /></td></tr>
                     </table>
                  </div>
                  
                  <!-- Navigatie -->
                  <div id="hoofdmenu" class="navigatie">
                     <ul>
                        <li><a class="menubalk" href="#inhoudsopgave" title="">Inhoudsopgave</a></li>
                        <xsl:for-each select="//imropt:TekstObject">
                           <xsl:choose>
                             <xsl:when test="imropt:niveau = 1">
                              <li>
                                 <a class="menubalk" >
                                    <xsl:attribute name="href" >#<xsl:value-of select="@identificatie"/></xsl:attribute>
                                    <xsl:value-of select="imropt:titelInfo/imropt:TitelInfo/imropt:label" /> <xsl:value-of select="imropt:titelInfo/imropt:TitelInfo/imropt:nummer" /> <xsl:value-of select="imropt:titelInfo/imropt:TitelInfo/imropt:naam" />
                                 </a>
                              </li>
                             </xsl:when>
                             <xsl:when test="imropt:niveau = 2 and imropt:typeTekst = 'document'">
                              <li>
                                 <a class="menubalk" >
                                    <xsl:attribute name="href" >#<xsl:value-of select="@identificatie"/></xsl:attribute>
                                    <!--<xsl:value-of select="imropt:titelInfo/imropt:TitelInfo/imropt:label" /> <xsl:value-of select="imropt:titelInfo/imropt:TitelInfo/imropt:nummer" />--> <xsl:value-of select="imropt:titelInfo/imropt:TitelInfo/imropt:naam" />
                                 </a>
                              </li>
                             </xsl:when>
                           </xsl:choose>
                        </xsl:for-each>
                        <!-- link naar ruimtelijke plannen -->
                        <li><a class="menubalk" href="http://www.ruimtelijkeplannen.nl/web-roo/?planidn={//imropt:FeatureCollectionIMROPT/imropt:TekstMetadata/imropt:verwijzingNaarPlangebied}">Kaart</a></li>
                     </ul>
                  </div>
               </div>

               <!-- Alle inhoud -->
               <div id="inhoud" class="inhoud">
                  <xsl:for-each select="//imropt:TekstObject">
                     <xsl:apply-templates select="." />
                  </xsl:for-each>
               </div>

               <!-- Eind -->
               <div id="eind" class="eind"></div>
            </div>
         </body>
      </html>
   </xsl:template>
   
   <xsl:template match="imropt:TekstObject">
   
      <!-- Voeg identificatie toe als id aan een XHTML div-element -->
      <div xmlns="http://www.w3.org/1999/xhtml">
         <!-- pointer voor xhtml -->
         <xsl:attribute name="id" >
           <xsl:value-of select="@identificatie"/>
         </xsl:attribute>

         <!-- Speciale classes -->
         <xsl:if test="imropt:objectType='begripsbepaling'">
            <xsl:attribute name="class">begripsbepaling</xsl:attribute>
         </xsl:if>
        
         <xsl:variable name="titelLabelEnNummer" select='concat (translate(substring(imropt:titelInfo/imropt:TitelInfo/imropt:label, 1, 1), "abcdefghijklmnopqrstuvwxyz", "ABCDEFGHIJKLMNOPQRSTUVWXYZ"), translate(substring(imropt:titelInfo/imropt:TitelInfo/imropt:label, 2), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), " ", imropt:titelInfo/imropt:TitelInfo/imropt:nummer, "  ")' />
         <xsl:variable name="titelNaam" select='imropt:titelInfo/imropt:TitelInfo/imropt:naam' />
         
         <!-- Afhankelijk van het objectniveau wordt de titel gegenereerd -->
         <!-- Soms is er een externeVerwijzingLink, als deze er is, dan kan op de titel worden doorgeklikt -->
         <xsl:choose>
           <xsl:when test="imropt:niveau = 0">
              
              <h1><xsl:value-of select="//imropt:FeatureCollectionIMROPT/imropt:TekstMetadata/imropt:naam" /></h1>
           </xsl:when>
           <xsl:when test="imropt:niveau = 1">
              <hr />  <!-- Altijd vooraf gegaan door een horizontale lijn -->
              <xsl:choose>
                 <xsl:when test='normalize-space($titelNaam) = ""'><b><xsl:call-template name="titelWeergeven" /></b></xsl:when>
                 <xsl:otherwise><h1><xsl:call-template name="titelWeergeven" /></h1></xsl:otherwise>
              </xsl:choose>
           </xsl:when>
           <xsl:when test="imropt:niveau = 2">
              <!-- bijlagen bij regels en bijlagen bij toelichting krijgen hiermee ook een horizontale lijn-->
              <xsl:if test="imropt:typeTekst = 'document'">
                 <hr />
              </xsl:if>
              <xsl:choose>
                 <xsl:when test='normalize-space($titelNaam) = ""'><b><xsl:call-template name="titelWeergeven" /></b></xsl:when>
                 <xsl:otherwise><h2><xsl:call-template name="titelWeergeven" /></h2></xsl:otherwise>
              </xsl:choose>
           </xsl:when>
           <xsl:when test="imropt:niveau = 3">
              <xsl:choose>
                 <xsl:when test='normalize-space($titelNaam) = ""'><b><xsl:call-template name="titelWeergeven" /></b></xsl:when>
                 <xsl:otherwise><h3><xsl:call-template name="titelWeergeven" /></h3></xsl:otherwise>
              </xsl:choose>
           </xsl:when>
           <xsl:when test="imropt:niveau = 4">
              <xsl:choose>
                 <xsl:when test='normalize-space($titelNaam) = ""'><b><xsl:call-template name="titelWeergeven" /></b></xsl:when>
                 <xsl:otherwise><h4><xsl:call-template name="titelWeergeven" /></h4></xsl:otherwise>
              </xsl:choose>
           </xsl:when>
           <xsl:when test="imropt:niveau = 5">
              <xsl:choose>
                 <xsl:when test='normalize-space($titelNaam) = ""'><b><xsl:call-template name="titelWeergeven" /></b></xsl:when>
                 <xsl:otherwise><h5><xsl:call-template name="titelWeergeven" /></h5></xsl:otherwise>
              </xsl:choose>
           </xsl:when>
           <xsl:otherwise>
              <xsl:choose>
                 <xsl:when test='normalize-space($titelNaam) = ""'><b><xsl:call-template name="titelWeergeven" /></b></xsl:when>
                 <xsl:otherwise><h6><xsl:call-template name="titelWeergeven" /></h6></xsl:otherwise>
              </xsl:choose>
           </xsl:otherwise>
         </xsl:choose>

         <!-- Voeg nu de tekst toe (op niveau 0 is dit de kaft, dus dit moet voor de inhoudsopgave komen) -->         
         <xsl:apply-templates select="xhtml:tekst" />

         <!-- Alleen op niveau 0 de inhoudsopgave genereren -->
         <xsl:if test="imropt:niveau = 0">  
            <div id="inhoudsopgave">
               <h1>Inhoudsopgave</h1>         
               <xsl:for-each select="//imropt:TekstObject">
                  <xsl:variable name="titelLabelEnNummerEnNaam" select='concat (translate(substring(imropt:titelInfo/imropt:TitelInfo/imropt:label, 1, 1), "abcdefghijklmnopqrstuvwxyz", "ABCDEFGHIJKLMNOPQRSTUVWXYZ"), translate(substring(imropt:titelInfo/imropt:TitelInfo/imropt:label, 2), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), " ", imropt:titelInfo/imropt:TitelInfo/imropt:nummer, "  ", imropt:titelInfo/imropt:TitelInfo/imropt:naam)' />
                  <xsl:choose>
                     <xsl:when test="imropt:niveau = 1">
                        <br />
                        <div class="inspring0">  
                           <a class="inhoudsopgave">  
                              <xsl:attribute name="href" >#<xsl:value-of select="@identificatie"/></xsl:attribute>
                              <xsl:value-of select='$titelLabelEnNummerEnNaam'/>
                           </a>
                        </div>
                     </xsl:when>
                     <xsl:when test="imropt:niveau = 2">
                        <div class="inspring1">  
                           &#160;&#160;&#160;&#160;&#160;&#160;<a class="inhoudsopgave">
                              <xsl:attribute name="href" >#<xsl:value-of select="@identificatie"/></xsl:attribute>
                              <xsl:value-of select='$titelLabelEnNummerEnNaam'/>
                           </a>
                        </div>
                     </xsl:when>
                     <xsl:when test="imropt:niveau = 3">
                        <div class="inspring2">  
                           &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<a class="inhoudsopgave">  
                              <xsl:attribute name="href" >#<xsl:value-of select="@identificatie"/></xsl:attribute>
                              <xsl:value-of select='$titelLabelEnNummerEnNaam'/>
                           </a>
                        </div>
                     </xsl:when>
                  </xsl:choose>
               </xsl:for-each>
            </div>
         </xsl:if>
      </div>
   </xsl:template>
                 
   <xsl:template name="titelWeergeven">
     <xsl:variable name="titelLabelEnNummer" select='concat (translate(substring(imropt:titelInfo/imropt:TitelInfo/imropt:label, 1, 1), "abcdefghijklmnopqrstuvwxyz", "ABCDEFGHIJKLMNOPQRSTUVWXYZ"), translate(substring(imropt:titelInfo/imropt:TitelInfo/imropt:label, 2), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"), " ", imropt:titelInfo/imropt:TitelInfo/imropt:nummer, "  ")' />
     <xsl:variable name="titelNaam" select='imropt:titelInfo/imropt:TitelInfo/imropt:naam' />
     <xsl:value-of select='$titelLabelEnNummer' />
       <xsl:choose>
          <xsl:when test="imropt:externeVerwijzingLink">
             <a>
                <xsl:attribute name="href">
                  <xsl:value-of select="imropt:externeVerwijzingLink"/>
                </xsl:attribute>
                <xsl:value-of select="$titelNaam" />
             </a>
          </xsl:when>
          <xsl:otherwise>
             <xsl:value-of select="$titelNaam" />
          </xsl:otherwise>
       </xsl:choose>
   </xsl:template>
   
   <xsl:template match="imropt:tekst">
      <xsl:apply-templates />
   </xsl:template>
   
   <xsl:template match="xhtml:tekst">
      <xsl:apply-templates />
   </xsl:template>

   <xsl:template match="imropt:verwijzingNorm">
      <xsl:value-of select="." />&#160;
   </xsl:template>

   <xsl:template match="imropt:verwijzingNaarPlangebied">
      <p><xsl:value-of select="@xl:href" /></p>
   </xsl:template>
   
   <xsl:template match="imropt:toegevoegd">
       <ins xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates select="@*"/><xsl:apply-templates /></ins>
   </xsl:template>
   
   <xsl:template match="imropt:verwijderd">
       <del xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates select="@*"/><xsl:apply-templates /></del>
   </xsl:template>
   
   <xsl:template match="imropt:interneVerwijzing">
       <a xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates select="@*"/><xsl:apply-templates /></a>
   </xsl:template>

   <xsl:template match="imropt:externeVerwijzing">
       <a xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates select="@*"/><xsl:apply-templates /></a>
   </xsl:template>
   
   <xsl:template match="imropt:voetnoot">
      <span xmlns="http://www.w3.org/1999/xhtml" class="voetnoot">
          <a href="#ie-void">
            <sup>voetnoot<span>: <xsl:apply-templates /></span></sup>
          </a>
       </span>
   </xsl:template>
   
<!--   <xsl:template match="@imropt:identificatie">
      <p xmlns="http://www.w3.org/1999/xhtml">
         <xsl:attribute name="id">
           <xsl:value-of select="."/>
         </xsl:attribute>
      </p>
   </xsl:template>
-->

   <xsl:template match="@xl:href">
      <xsl:attribute name="href">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>
   
   <xsl:template match="@xl:type">
      <xsl:attribute name="type">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>

   <xsl:template match="xhtml:p">
       <p xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates /></p>
   </xsl:template>

   <xsl:template match="xhtml:br">
       <br xmlns="http://www.w3.org/1999/xhtml" />
   </xsl:template>

   <xsl:template match="xhtml:em">
       <em xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates /></em>
   </xsl:template>

   <xsl:template match="xhtml:strong">
       <strong xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates /></strong>
   </xsl:template>

   <xsl:template match="xhtml:ul">
       <ul xmlns="http://www.w3.org/1999/xhtml">

         <!-- list-style-type en type zijn niet toegestaan => vertaal naar class -->
         <xsl:choose>
            <xsl:when test="@class">
               <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@list-style-type">
               <xsl:attribute name="class"><xsl:value-of select="@list-style-type"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@type">
               <xsl:attribute name="class"><xsl:value-of select="@type"/></xsl:attribute>
            </xsl:when>
         </xsl:choose>
         <xsl:apply-templates select="@*" />
         <xsl:apply-templates />
       </ul>
   </xsl:template>

   <xsl:template match="xhtml:ol">
       <ol xmlns="http://www.w3.org/1999/xhtml">

         <!-- list-style-type en type zijn niet toegestaan => vertaal naar class -->
         <xsl:choose>
            <xsl:when test="@class">
               <xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@list-style-type">
               <xsl:attribute name="class"><xsl:value-of select="@list-style-type"/></xsl:attribute>
            </xsl:when>
            <xsl:when test="@type">
               <xsl:attribute name="class"><xsl:value-of select="@type"/></xsl:attribute>
            </xsl:when>
         </xsl:choose>
         <xsl:apply-templates select="@*" />
         <xsl:apply-templates />
       </ol>
   </xsl:template>

   <xsl:template match="xhtml:li">
       <li xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates select="@*" />
         <xsl:apply-templates />
       </li>
   </xsl:template>

   <xsl:template match="xhtml:table">
       <table xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates select="@*"/> <xsl:apply-templates /></table>
   </xsl:template>
   
   <xsl:template match="xhtml:td">
       <td xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates /></td>
   </xsl:template>

   <xsl:template match="xhtml:tr">
       <tr xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates /></tr>
   </xsl:template>

   <xsl:template match="xhtml:img">
      <img xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates select="@*"/></img>
   </xsl:template>

   <xsl:template match="@value">
      <xsl:attribute name="value">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>

   <xsl:template match="@type">
      <xsl:attribute name="type">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>

   <xsl:template match="@list-style-type">
      <!-- ignore -->
   </xsl:template>

   <xsl:template match="@width">
      <xsl:attribute name="width">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>

   <xsl:template match="@height">
      <xsl:attribute name="height">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>

   <xsl:template match="@alt">
      <xsl:attribute name="alt">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>

   <xsl:template match="@src">
      <xsl:attribute name="src">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>   

   <xsl:template match="@class">
      <xsl:attribute name="class">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>   

   <xsl:template match="@id">
      <xsl:attribute name="id">
        <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>   

</xsl:stylesheet>
