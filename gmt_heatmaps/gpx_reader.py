#!/usr/bin/env python3

import gpxpy
import numpy as np
import pandas as pd
import sys

gpx_file = open(sys.argv[1], 'r')
gpx = gpxpy.parse(gpx_file)
track_coords = []

for track in gpx.tracks:
	for segment in track.segments:
		for point in segment.points:
			track_coords.append((point.latitude, point.longitude, point.elevation, point.time))

gps_track = pd.DataFrame(track_coords, columns=['Latitude','Longitude','Elevation','Time'])
gps_track.to_csv('temp.csv', header=False)
