---
---

$ = jQuery

$(document).ready ->
    elements = $(".container")
    loaddata element for element in elements
  
loaddata = (e) ->
    file = $(e).attr("data-files")
    $.get(file).complete (data) ->
        createchart(data.responseText, e)

createchart = (x, element) ->
    xml = $.parseXML(x)
    xmlDoc = $(xml)
    i = 0
    j = 0
    points = xmlDoc.find("Trackpoint")
    elevation = new Array
    pace = new Array
    lastpnt = parseTrackPoint(points[0])
    elevationtemp = 0
    pacetemp = 0
    for i in [1...points.length]
        p = parseTrackPoint(points[i], lastpnt)
        # length -> km and height -> m
        elevationtemp += p.elevation
        pacetemp += p.pace
        if i % 5 == 0
            elevation[j] = [p.distance, elevationtemp / 5]
            pace[j++] = [p.distance, pacetemp / 5]
            elevationtemp = 0
            pacetemp = 0
        lastpnt = p
    container = $(element).attr("id")
    c = new Highcharts.Chart(
            chart: { renderTo: container, zoomType: 'x' }
            title: { text: null }
            subtitle: {
                text: if not document.ontouchstart? then 'Click and drag in the plot area to zoom in' else 'Drag your finger over the plot to zoom in'
            }
            xAxis: {
                title: { text: null },
                type: 'linear',
                minRange: 5,
                labels: {
                    formatter: () ->
                        v = convertToKm this.value
                        f = "#{v} km"
                }
            }
            yAxis: [
                {
                    title: { text: null },
                    endOnTick: false
                },
                {
                    title: { text: null },
                    endOnTick: false
                }
            ]
            tooltip: {
                formatter: () ->
                    if this.series.name == 'Elevation'
                        x = convertToKm this.x
                        y = extround this.y, 100
                        t = "<strong>Distance:</strong> #{x} km<br /><strong>Elevation:</strong> #{y} m"
                    else if this.series.name == 'Pace'
                        x = convertToKm this.x
                        y = extround this.y, 100
                        t = "<strong>Distance:</strong> #{x} km<br /><strong>Pace:</strong> #{y} km/h"
            }
            legend: { enabled: false }
            plotOptions: {
                spline: {
                    lineWidth: 2,
                    lineColor: '#06ABF3',
                    marker: { enabled: false, states: { hover: { enabled: true, radius: 4 } } },
                    shadow: true,
                    states: { hover: { lineWidth: 3 } }
                }
                area: {
                    fillColor: { linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1}, stops: [[0, 'rgba(210,210,210,0.5)'], [1, 'rgba(64,64,64,0.5)']] },
                    lineWidth: 1,
                    lineColor: '#666666',
                    marker: { enabled: false, states: { hover: { enabled: true, radius: 4 } } },
                    shadow: true,
                    states: { hover: { lineWidth: 2 } }
                }
            }
            series: [
                {
                    type: 'area',
                    name: 'Elevation',
                    data: elevation,
                    yAxis: 0
                },
                {
                    type: 'spline'
                    name: 'Pace',
                    data: pace,
                    yAxis: 1
                }
            ]
            #series: [{ type: 'area', name: unescape('H%F6henmeter'), pointInterval: 10,  data: elevation }]
        )

extround = (number, n_stelle) ->
    z = Math.round(number * n_stelle) / n_stelle

convertToKm = (m) ->
    km = extround m / 1000, 100

degToRad = (deg) ->
    r = deg * Math.PI / 180
    
# thanks to:
#   http://gpx.tomaskafka.com
#   https://github.com/tkafka/Javascript-GPX-track-viewer
#   http://www.movable-type.co.uk/scripts/latlong.html
pointDistance = (pnt1, pnt2) ->
    lat1 = pnt1.lat
    lon1 = pnt1.lon
    lat2 = pnt2.lat
    lon2 = pnt2.lon
	# km
    R = 6371
    dLat = Math.sin(degToRad(lat2-lat1) / 2)
    dLon = Math.sin(degToRad(lon2-lon1) / 2)
    a = dLat * dLat + Math.cos(degToRad(lat1)) * Math.cos(degToRad(lat2)) * dLon * dLon
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    # km
    R * c

parseTrackPoint = (trackpoint, lastpnt) ->
    p = {}
    # length -> km and height -> m
    p.distance = parseFloat($(trackpoint).find("DistanceMeters").text())
    p.elevation = parseFloat($(trackpoint).find("AltitudeMeters").text())
    p.time = Date.parse($(trackpoint).find("Time").text())
    p.lat = parseFloat($(trackpoint).find("LatitudeDegrees").text())
    p.lon = parseFloat($(trackpoint).find("LongitudeDegrees").text())
    p.pace = 0
    if lastpnt
        timediff = p.time - lastpnt.time
        if timediff > 0
            dst = pointDistance(lastpnt, p)
            p.pace = dst / timediff * 1000 * 60 * 60
    return p
