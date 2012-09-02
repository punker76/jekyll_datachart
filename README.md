# Jekyll Datachart

Jekyll Datachart is my first own jekyll plugin for octopress. You can easily embed data charts with your pace and elevation from your running or cycling tracks.

##How it works

Installation / Configuration
============================

To use this plugin you need coffeescript, add it to your Gemfile

	source "http://rubygems.org"

	group :development do
	  gem 'coffee-script', '~> 2.2.0'
	end

Then update your bundle

	bundle update

Second, you need Highcharts JS (Free for Non-commercial)

	http://www.highcharts.com/

Put the highcharts.js at your javascripts directory.
	
Put the contents of 'plugins' in your 'plugins' directory and the contents of 'source' in your 'source' directory (just copy the directories if you don't have those directories yet).
	
Put the following configuration in your _config.yml

	# data charting
	datachart:
			dimensions:
					   width: 750
					   height: 200

Include {% include jekyll_datachart.html %} in your head.html

	<head>
		...

		{% capture canonical %}{{ site.url }}{% if site.permalink contains '.html' %}{{ page.url }}{% else %}{{ page.url | remove:'index.html' }}{% endif %}{% endcapture %}
		<link rel="canonical" href="{{ canonical }}">
		<link href="{{ root_url }}/favicon.png" rel="icon">
		<link href="{{ root_url }}/stylesheets/screen.css" media="screen, projection" rel="stylesheet" type="text/css">

		{% include jekyll_datachart.html %}

		<script src="{{ root_url }}/javascripts/modernizr-2.0.js"></script>
		<script src="{{ root_url }}/javascripts/ender.js"></script>
		<script src="{{ root_url }}/javascripts/octopress.js" type="text/javascript"></script>
		<link href="{{ site.subscribe_rss }}" rel="alternate" title="{{site.title}}" type="application/atom+xml">
		{% include custom/head.html %}
		{% include google_analytics.html %}

		...
	</head>

Usage
=====

Set the relevant values in your pages and posts (first version of this plugin understands only tcx files, next verson understands gpx and kml too):

	datachart:
		files:
			- http://yourfirstfile.tcx
			- http://yoursecondfile.tcx

Include the render_datachart tag in your posts:

    {{% render_datachart %}

Optionally, you can specify the width and height:
    
    {% render_datachart 500,500 %}

## What's next

* More formats: gpx and kml
* Any more ideas? ... 

## License and copyright

Copyright 2012 Jan Karger

Distributed under the terms of the GNU General Public License

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Use it with your own risk.
==========================