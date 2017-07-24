#!/usr/bin/env python3

# -*- coding: utf-8 -*-
"""
gpsCat

"""

import gpxpy 
import matplotlib.pyplot as plt
import pandas as pd

gpx_file = open('170507.GPX', 'r')
gpx = gpxpy.parse(gpx_file)
track_coords = []

for track in gpx.tracks:
	for segment in track.segments:
		for point in segment.points:
			track_coords.append((point.latitude, point.longitude, point.elevation, point.time))

cat_track = pd.DataFrame(track_coords, columns=['Latitude','Longitude','Elevation','Time'])

#plt.plot(cat_track['Longitude'],cat_track['Latitude'])
#plt.show()

plt.plot(cat_track['Time'], cat_track['Elevation'])
plt.show()

