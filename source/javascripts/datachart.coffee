---
---

$ = jQuery

$(document).ready ->
  elements = $(".container")
  loaddata element for element in elements
  
loaddata = (e) ->
  file = $(e).attr("data-files")
  $.get(file).complete (data) ->
    createchart data.responseText, e

extround = (number, n_stelle) ->
	z = Math.round(number * n_stelle) / n_stelle

convertToKm = (m) ->
	km = extround m / 1000, 100

createchart = (x, element) ->
	xml = $.parseXML(x)
	xmlDoc = $(xml)
	i = 0
	elevation = new Array
	tpoints = xmlDoc.find("Trackpoint").each (x) ->
	  p = new Array
	  # length -> km
	  p[0] = parseFloat $(this).find("DistanceMeters").text()
	  #p[0] = convertToKm parseFloat $(this).find("DistanceMeters").text()
	  # height -> m
	  p[1] = parseFloat $(this).find("AltitudeMeters").text()
	  #p[1] = extround (parseFloat $(this).find("AltitudeMeters").text()), 100
	  elevation[i++] = p
	  #elevation[i++] = [ parseFloat $(this).find("DistanceMeters").text(), parseFloat $(this).find("AltitudeMeters").text()]
	container = $(element).attr("id")
	c = new Highcharts.Chart(
		chart: { renderTo: container, zoomType: 'x', spacingRight: 0, spacingTop: 10 }
		title: { text: null }
		subtitle: {
			text: if not document.ontouchstart? then 'Click and drag in the plot area to zoom in' else 'Drag your finger over the plot to zoom in'
		}
		xAxis: { title: { text: null }, type: 'linear', minRange: 5 }
		yAxis: { title: { text: 'Elevation (m)' }, min: 0, startOnTick: false, showFirstLabel: false }
		tooltip: { formatter: () ->
		  x = convertToKm this.x
		  y = extround this.y, 100
		  t = "<strong>Distance:</strong> #{x} km<br /><strong>Elevation:</strong> #{y} m"
		}
		legend: { enabled: false }
		plotOptions: {
			area: {
				fillColor: { linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1}, stops: [[0, 'rgba(210,210,210,0.5)'], [1, 'rgba(64,64,64,0.5)']] },
				lineWidth: 1,
				lineColor: '#4040ff',
				marker: { enabled: false, states: { hover: { enabled: true, radius: 5 } } },
				shadow: false,
				states: { hover: { lineWidth: 1 } }
			}
		}
		series: [{ type: 'area', name: 'Elevation (m)', data: elevation }]
		#series: [{ type: 'area', name: unescape('H%F6henmeter'), pointInterval: 10,  data: elevation }]
	)
