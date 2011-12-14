import sys, re, json, csv
import datetime
import dateutil.parser as dparser
from operator import itemgetter, attrgetter
import operator


data = list()

spamWriter = csv.writer(open('TBL_BIKE_FATALITIES_1995_2009.csv', 'wb'), delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)

labels = ['OBJECTID','CASE_NUM','CASE_YR','REF_MRKR','ACCD_DTE','ROAD_SYS','NUM_OF_FATALITIES','NUM_OF_INJURIES','REPORTABLE','POLICE_DEPT','INTERSECT_NUM','MUNI','PRECINCT','NUM_OF_VEH','ACCD_TYP','LOCN','TRAF_CNTL','LIGHT_COND','WEATHER','ROAD_CHAR','ROAD_SURF_COND','COLLISION_TYP','PED_LOC','PED_ACTN','EXT_OF_INJURIES','REGN_CNTY_CDE','LOW_NODE','HIGH_NODE','ACCD_TME','RPT_AGCY','DMV_ACCD_CLSF','ERR_CDE','COMM_VEH_ACC_IND','INTERSECT_IND','UTM_NORTHING','UTM_EASTING','GEO_SEGMENT_ID','GEO_NODE_ID','GEO_NODE_DISTANCE','GEO_NODE_DIRECTION','GEO_LCODE','HIGHWAY_IND','CASE_NUM_YR','X_COORD','Y_COORD','BoroName','BoroCD','StSenDist','SchoolDist','CounDist','CongDist','ElectDist','PjAreaName','Precinct_1','GEOID10','NAME10','DPHO','AssemDist']
boroughs = ['N1','N2','N3','N4','N5','N6']

csvfile = csv.reader(sys.stdin)

#get rid of the titles row

#get every row and split them into cells
j = 0
for cells in csvfile:
	i = 0
	row = dict()
	for cell in cells:
		row[labels[i]] = cell
		i+=1
	if j > 0:
		if float(row['ACCD_TYP']) == 3 and float(row['NUM_OF_FATALITIES']) > 0 and row['REGN_CNTY_CDE'] in boroughs:
			data.append(row)
			
			spamWriter.writerow(cells)
			
	j+=1

