#!/bin/bash
# Verkrijg IMWE208 bestanden uit WFS dmv script
#
# Auteur: Just van den Broecke
#
/bin/rm -f *.xml *.json

# GeoServer WFS
wget -O wfs-capabilities.xml 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetCapabilities'
wget -O wfs-featuretypes.xml 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=DescribeFeatureType'

wget -O wfs-gebied1.xml 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=imwe:gebied&maxFeatures=5&outputFormat=GML3'
wget -O wfs-gebied1.json 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=imwe:gebied&maxFeatures=5&outputFormat=JSON'

wget -O wfs-object1.xml 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=imwe:object&maxFeatures=5&outputFormat=GML3'
wget -O wfs-object1.json 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=imwe:object&maxFeatures=5&outputFormat=JSON'

wget -O wfs-welstandsniveaugebied1.xml 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=imwe:welstandsniveaugebied&maxFeatures=5&outputFormat=GML3'
wget -O wfs-welstandsniveaugebied1.json 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=imwe:welstandsniveaugebied&maxFeatures=5&outputFormat=JSON'

wget -O wfs-welstandsnota1.xml 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=imwe:welstandsnota&maxFeatures=5&outputFormat=GML3'
wget -O wfs-welstandsnota1.json 'http://108.171.173.8/data/imwe/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=imwe:welstandsnota&maxFeatures=5&outputFormat=JSON'

# imwe.nl deegree WFS
#
# wget -O imwe.nl-welstandsnota-compleet1.xml 'http://www.imwe.nl/getAllData?longitude=100475.830078125&latitude=409607.91015625'
wget -O imwe.nl-capabilities.xml 'http://www.imwe.nl/data?service=WFS&version=1.1.0&request=GetCapabilities'
wget -O imwe.nl-featuretypes.xml 'http://www.imwe.nl/data?service=WFS&version=1.1.0&request=DescribeFeatureType'
wget -O imwe.nl-welstandsniveaugebied1.xml 'http://www.imwe.nl/data?service=WFS&version=1.1.0&request=GetFeature&typeName=WelstandsNiveauGebied&maxFeatures=10'
wget -O imwe.nl-welstandsnnota1.xml 'http://www.imwe.nl/data?service=WFS&version=1.1.0&request=GetFeature&typeName=WelstandsNota&maxFeatures=10'

# Landgraaf compleet
# locatie: WGS84: 6.0167 50.9000  RD: 199285.410	323549.054
# werkt niet volledig...
# wget -O imwe.nl-wn-compleet-landgraaf.xml 'http://www.imwe.nl/getAllData?longitude=199285.410&latitude=323549.054'

wget -O imwe.nl-wn-landgraaf.xml 'http://www.imwe.nl/data?service=WFS&version=1.1.0&request=GetFeature&typeName=WelstandsNota&maxFeatures=2&filter=%3Cogc:Filter%20xmlns:app=%22http://www.deegree.org/app%22%20xmlns:gml=%22http://www.opengis.net/gml%22%20xmlns:ogc=%22http://www.opengis.net/ogc%22%3E%20%3CPropertyIsLike%20wildCard=%22*%22%20singleChar=%22?%22%20escape=%22\%22%3E%20%3CPropertyName%3EgemeenteNaam%20%3C/PropertyName%3E%20%3CLiteral%3ELandgraaf%3C/Literal%3E%20%3C/PropertyIsLike%3E%20%3C/ogc:Filter%3E'

# Ruimtelijke queries voor overige 3 elementen
url="http://www.imwe.nl/data?"
wget -O imwe.nl-wng-landgraaf.xml --header="Content-Type: text/xml" --post-file=queries/get-wniveau-landgraaf.xml $url
wget -O imwe.nl-wg-landgraaf.xml --header="Content-Type: text/xml" --post-file=queries/get-wgebied-landgraaf.xml $url
wget -O imwe.nl-wo-landgraaf.xml --header="Content-Type: text/xml" --post-file=queries/get-wobject-landgraaf.xml $url
