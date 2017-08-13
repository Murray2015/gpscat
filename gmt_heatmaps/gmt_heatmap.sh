#!/bin/bash

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
# Make grid of gps counts in bins
blockmean all_gpx_files.txt -Sn $rgn -I$precision > grid_counts.txt
nearneighbor grid_counts.txt $rgn -I$precision -Gheatmap.nc -S20e -N4
psxy $rgn $prj grid_counts.txt -P -B0.01 -SC0.02 -K > $outfile
grdimage $rgn $prj heatmap.nc  -B0.01 -O -t50 >> $outfile
ps2pdf $outfile heatmap.pdf
evince heatmap.pdf

## This now works. TODO - add scale, colorbar, borders, title, and background image. 
