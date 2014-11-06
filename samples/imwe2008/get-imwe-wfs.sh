#!/bin/bash
# Verkrijg IMWE208 bestanden uit WFS dmv script
#
# Auteur: Just van den Broecke
#
/bin/rm -f *.xml *.json

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
