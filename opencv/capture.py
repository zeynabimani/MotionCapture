import cv2
from datetime import datetime

HIGH_VALUE = 10000

capture1 = cv2.VideoCapture(1)
capture1.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc('M', 'J', 'P', 'G'))
capture1.set(cv2.CAP_PROP_EXPOSURE,0)
capture2 = cv2.VideoCapture(2)
capture2.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc('M', 'J', 'P', 'G'))
capture2.set(cv2.CAP_PROP_EXPOSURE,0)

width = int(capture1.get(cv2.CAP_PROP_FRAME_WIDTH))
height = int(capture1.get(cv2.CAP_PROP_FRAME_HEIGHT))
fps = capture1.get(cv2.CAP_PROP_FPS)

print(width, height, fps)
#path+now+_
counter = 1
while True:
    ret1, frame1 = capture1.read()
    ret2, frame2 = capture2.read()
    path = 'check/9/' + str(counter) + '_'
    now = datetime.now().strftime('_%H-%M-%S~%f')[:-4]
    if ret1:
        cv2.imshow('frame1', frame1)
        cv2.imwrite(path+now+'_1.jpg', frame1)
    if ret2:
        cv2.imshow('frame2', frame2)
        cv2.imwrite(path+now+'_2.jpg', frame2)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
    
    counter += 1


capture1.release()
capture2s.release()
cv2.destroyAllWindows()
