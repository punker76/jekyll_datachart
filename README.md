# Jekyll Datachart

Jekyll Datachart is my first own jekyll plugin for octopress. You can easily embed data charts with pace, elevation and heart rate that you recorded in a data file (tcx, slf, gpx and kml later?).

##How it works

Installation / Configuration
============================

To use this plugin you need coffeescript, add it to your Gemfile

	source "http://rubygems.org"

	group :development do
	  gem 'coffee-script', '~> 2.2.0'
	end

Then update your bundle

	bundle

Second, you need Highcharts JS (Free for non-commercial)

	http://www.highcharts.com/

Put the highcharts.js into your 'source/javascripts' directory.
	
Put the contents of 'plugins' in your 'source/plugins' directory and the contents of 'source' in your 'source' directory (just copy the directories if you don't have those directories yet).
	
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
			- http://yoursecondfile.slf

Include the render_datachart tag in your posts:

    {{% render_datachart %}

Optionally, you can specify the width and height:
    
    {% render_datachart 500,500 %}

## Supported data files

* tcx: Training Center Database XML by Garmin
* slf: SIGMA SLF file from SIGMA DATA CENTER 2.x

## What's next ?

* More formats: gpx and kml
* Any more ideas? ... 

## License and copyright

Copyright (c) 2012 Jan Karger

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

See <http://opensource.org/licenses/MIT/>.

Use it with your own risk.
==========================