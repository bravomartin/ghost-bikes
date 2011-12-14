import sys, re, json, csv
import datetime
import dateutil.parser as dparser
from operator import itemgetter, attrgetter
import operator


data = list()
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
	j+=1


for row in data:
#	"7/29/2002 4:00:00 PM"
	try:
		row['ACCD_TME'] = datetime.datetime.strptime(row['ACCD_TME'], "%m/%d/%Y %H:%M:%S %p")
	except ValueError:
	#	print row["ACCD_TME"] + " has date only"
 		row['ACCD_TME'] = datetime.datetime.strptime(row['ACCD_TME']+ " 12:00:00 PM", "%m/%d/%Y %H:%M:%S %p")


sorted_data = sorted(data, key=itemgetter('ACCD_TME'))


# a very old date
last = datetime.datetime.strptime("7/29/1990 4:00:00 PM", "%m/%d/%Y %H:%M:%S %p")
mindif = datetime.timedelta(500)
difs = list()
for row in sorted_data:
	dif = row['ACCD_TME']-last
	last = row['ACCD_TME']
	difs.append([dif,row['ACCD_TME']])
	if dif < mindif:
		mindif = dif
#		print dif
#		print row['ACCD_TME']

for i in difs: #sorted(difs, key=itemgetter(0)):
	print str(i[0]/8587) + ' '+ str(i[1])
#	print i/1073


for row in sorted_data:
	out = row['ACCD_TME'].isoformat() + ',' + row['NUM_OF_FATALITIES'] + ',' + row['X_COORD'] + ',' + row['Y_COORD']


#	print out

