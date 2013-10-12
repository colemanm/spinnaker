#!/usr/bin/env ruby

chart = ARGV[0]

section = File.basename(ARGV[0], ".KAP")

`gdal_translate -of GTiff #{chart} #{section}_raw.tif`
`gdalwarp -t_srs EPSG:4326 #{section}_raw.tif #{section}.tif`
`rm #{section}_raw.tif`

puts "Created #{section}.tif."
