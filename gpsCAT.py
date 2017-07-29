#!/usr/bin/env python3

# -*- coding: utf-8 -*-
"""
gpsCat

"""

import gpxpy
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import mplleaflet
from mpl_toolkits.basemap import Basemap

gpx_file = open('170507.GPX', 'r')
gpx = gpxpy.parse(gpx_file)
track_coords = []

for track in gpx.tracks:
	for segment in track.segments:
		for point in segment.points:
			track_coords.append((point.latitude, point.longitude, point.elevation, point.time))

cat_track = pd.DataFrame(track_coords, columns=['Latitude','Longitude','Elevation','Time'])

## Find the smallest and greatest coordinates, for plotting
maxlat = np.max(cat_track.Latitude)
maxlong = np.max(cat_track.Longitude)
minlat = np.min(cat_track.Latitude)
minlong = np.min(cat_track.Longitude)

print(maxlat, maxlong, minlat, minlong)

## Standard plot with no background
# plt.plot(cat_track['Longitude'],cat_track['Latitude'])
# plt.show()

## Can't get this working yet...
# cat_track = cat_track.dropna()
# fig = plt.figure(1)
# plt.plot(cat_track['Longitude'], cat_track['Latitude'], color='darkorange', linewidth=5, alpha=0.5)
# mplleaflet.display(fig=fig, tiles='esri_aerial')
# plt.show()

#
m = Basemap(projection='merc', lat_0 = ((minlat + maxlat)/2.0), lon_0 = ((minlong + maxlong)/2.0),
            llcrnrlat = minlat,
            llcrnrlon = maxlong,
            urcrnrlat = maxlat,
            urcrnrlon = minlong,
            resolution='l', epsg=4326)
m.fillcontinents(color='coral',lake_color='aqua')
## Note this is an infuriating bug! must have cat_track.Latitude.values. If you don't, the latlon keyword causes random crashes.
m.plot(cat_track.Longitude.values, cat_track.Latitude.values, linewidth=1.5, color='r', latlon=True)
plt.title("catGPS track")
plt.show()

# plt.plot(cat_track['Time'], cat_track['Elevation'])
# plt.show()
