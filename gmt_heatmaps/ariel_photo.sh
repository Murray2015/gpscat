#!/bin/bash

infile="./Download_home_778784/getmapping_rgb_25cm_1941283/sp/sp0484_l2_250_02.jpg"
# grdimage -Dr -R404000/405000/284000/285000 -JU+29/6i $infile -P -B0 > test_map.ps

# ogr2ogr -s_srs "+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.999601 +x_0=400000 +y_0=-100000 +ellps=airy +units=m +no_defs +nadgrids=d:\ostn02_ntv2.gsb" -t_srs EPSG:4326 $infile ${infile}_reproj
gdalwarp $infile ${infile}_reproj -S_srs EPSG:27700 -t_srs "+proj=longlat +ellps=WGS84" -TFW YES
# evince test_map.ps
