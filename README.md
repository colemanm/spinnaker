Spinnaker is a set of tools for working with NOAA nautical chart data. NOAA publishes electronic nautical chart data (ENCs), and the printable raster nautical chart series (RNCs).

* [Download ENCs](http://www.charts.noaa.gov/ENCs/ENCs.shtml)
* [Download RNCs](http://www.charts.noaa.gov/RNCs/RNCs.shtml)

## Tools

### `rnc_convert.rb`

Takes a RNC file (`.KAP`) converts and projects to GeoTIFF.

    ./rnc_convert.rb 11411.KAP

Writes a TIFF file out to the current directory.

## OpenStreetMap

Spinnaker is a script for importing OpenSeaMap tagged data from OpenStreetMap into your own PostGIS database. It uses imposm, an OSM importing utility, to create a custom set of database tables containing nautical features like seamarkers, buoys, channels, etc.

Once [imposm and its prerequisites are running](http://imposm.org/docs/imposm/latest/install.html), you can use the spinnaker custom table file to import nautical features from OSM extracts.

## Importing

Run the import like this:

    imposm -U dbuser -d dbname -m spinnaker-mapping.py --read --write --optimize --deploy-production-tables florida.osm.pbf

## Resources

* [Extracts by region](http://download.geofabrik.de/openstreetmap/), from Geofabrik
* [OpenSeaMap tagging](http://wiki.openstreetmap.org/wiki/Openseamap/Seamark_Tag_Values)
* [OpenSeaMap](http://www.openseamap.org/)
* [Chart Previews](http://atoll.floridamarine.org/Quickmaps/KMZ_download-nauticalcharts.htm)
