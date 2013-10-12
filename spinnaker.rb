#!/usr/bin/env ruby

require 'json'
require 'thor'
require 'active_support/all'
require 'rgeo/geo_json'

class Spinnaker < Thor

  desc "list", "Show list of available S-57 data layers"
  method_option :file, aliases: "-f", desc: "File to list"
  def list
    `ogrinfo -so -al #{options[:file]} | grep "Layer name"`
  end

  desc "soundings", "Extract and convert sounding data from S-57"
  method_option :directory, aliases: "-d", desc: "Directory of raw S-57 data files"
  method_option :path, aliases: "-p", desc: "Path to save data"
  def soundings
    Dir.glob(options[:directory] + '/**/*.000') do |file|
      section = File.basename(file, ".000")
      `ogr2ogr -f GeoJSON #{options[:path]}/#{section}_soundings_raw.geojson #{file} SOUNDG`
      puts "Converted #{section}."

      collection = RGeo::GeoJSON.decode(File.read("#{options[:path]}/#{section}_soundings_raw.geojson"), :json_parser => :json)

      geojson = []

      collection.each do |f|
        %w"FFTP_RIND EXPSOU NOBJNM OBJNAM QUASOU SOUACC TECSOU VERDAT STATUS INFORM NINFOM NTXTDS SCAMAX TXTDSC REDCAT RECIND".each do |k|
          f.keys.delete(k)
        end
        geojson << RGeo::GeoJSON.encode(f)
      end

      File.open("#{options[:path]}/#{section}_soundings.geojson","w") do |f|
        f.write(geojson.to_json)
        puts "Saved #{section}_soundings.geojson."
        # File.delete("#{options[:path]}/#{section}_soundings_raw.geojson")
      end

    end
  end

end

Spinnaker.start
