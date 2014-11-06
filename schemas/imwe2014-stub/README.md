Deze directory bevat een zogenaamde "stubbed versie" van de IMWE 2014 XSDs.
"Stubbed" betekent dat met name alle GML-gerelateerde definities (alles in de GML-namespace) zijn afgevangen.
De in de IMWE2014 XSD gebruikte GML 3.2.1.2-subset zijn opgenomen in het bestand "gmlstubs.xsd".
Klasse definities voor de object/feature hierarchy zijn onveranderd opgenomen. Andere definities zoals geometrieën
en XLink constructies zoals AssociationAttributeGroup zijn "stubbed" dwz als leeg of string gedefinieërd.

De reden voor deze opzet is om initiële IMWE 2014 proefbestanden te kunnen genereren vanuit de XSDs. Wanneer de volle
GML definties worden gebruikt werkt de meeste/alle software om bestanden te genreren niet vanwege invaliditeits-problemen
met de GML-XSDs. Dit probleem is bekend. Ook het genereren van geometry-elementen is onmogelijk. Op dit moment
wordt XML-generatie gedaan middels de tool IntelliJ IDEA, maar ook Eclipse en zelf online-tools kunnen XML
op grond van een XSD genereren (mits de XSD/DTD niet te complex is).

Allereerst worden de proefbestanden gegenereerd voor de voornaamste IMWE2014 elementen:
Welstandsnota, Welstandsgebied, Welstandsniveau en Welstandsobject. Omdat de IMWE bestands container
gebaseerd is op een zgn GML Feature Collection dmv gml:AbstractFeature met daarin AbstractFeatureMemberType elementen
kan niet automatisch een compleet proefbestand hiervoor gegenereerd worden. Onder de samples map
worden hiervoor proefbestanden handmatig opgebouwd met daarin de gegenereerde Welstands* elementen.

In een volgende stap worden de proefbestanden omgezet naar zgn "templates" waarin actuele waarden zijn wegegelaten
om ingevuld te worden in een transformatie proces met als input IMWE2008 bestanden of WFS services.




