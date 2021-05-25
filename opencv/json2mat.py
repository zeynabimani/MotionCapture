
import numpy, scipy.io

import json
  
# Opening JSON file
f = open('keypoints1.json',)
    
# returns JSON object as 
# a dictionary
data = json.load(f)

# Iterating through the json
# list
for i in data['people']:
    a=i['pose_keypoints_2d']
    
scipy.io.savemat("data1.mat", mdict={'arr': a})

# Closing file
f.close()