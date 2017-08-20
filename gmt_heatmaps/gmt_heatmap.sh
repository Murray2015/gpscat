#!/bin/bash

gmtset PS_MEDIA A3

## Make file list to loop over, read gpx files with python and dump to csv
# files=`ls *GPX`
# rm all_gpx_files.csv
#
# for i in $files
# do
# ./gpx_reader.py $i
# echo ">" >> all_gpx_files.csv
# cat temp.csv >> all_gpx_files.csv
# done
#
# ## Change csv to GMT friendly format
# awk 'BEGIN{FS=","}{if($1 != ">") print $3, $2, 1; else print ">"}' all_gpx_files.csv > all_gpx_files.txt

## Use blockmean to count the totals in the grid square
precision=0.00005
rgn=`gmtinfo -I0.0001 all_gpx_files.txt`
prj="-JM6i"
outfile="heatmap.ps"
grdfile="heatmap.nc"
scalelat=`gmtinfo all_gpx_files.txt -I0.001 | awk 'BEGIN{FS="/"}{print $3}'`

# Make grid of gps counts in bins
blockmean all_gpx_files.txt -Sn $rgn -I$precision > grid_counts.txt
nearneighbor grid_counts.txt $rgn -I$precision -G${grdfile} -S20e -N4
makecpt -Chot `grdinfo ${grdfile} -T0.1` > heatmap.cpt
psxy $rgn $prj grid_counts.txt -P -SC0.02 -K > $outfile
pscoast $rgn $prj -Ia -Lx5.25i/0.5i+c${scalelat}+w100e -K -O >> $outfile
grdimage $rgn $prj $grdfile -Cheatmap.cpt -B0.001SWne -t50 -K -O >> $outfile
psscale -Cheatmap.cpt -D6.5i/3i+w4i/0.25i -B10 -O >> $outfile
ps2pdf $outfile heatmap.pdf
evince heatmap.pdf

## This now works. TODO - add background image.
