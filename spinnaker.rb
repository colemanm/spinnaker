#!/usr/bin/env ruby

require 'json'
require 'gdal-ruby/ogr'
require 'thor'

class Spinnaker < Thor

  desc "list", "Show list of available S-57 data layers"
  method_option :file, aliases: "-f", desc: "File to list"
  def list
    `ogrinfo -so -al #{options[:file]} | grep "Layer name"`
  end

  desc "soundings", "Extract and convert sounding data"
  method_option :file, aliases: "-f", desc: "File to list"
  def soundings
    `ogr2ogr -f GeoJSON #{options[:file].downcase}_soundings.json #{options[:file]} SOUNDG`
  end

end

Spinnaker.start
