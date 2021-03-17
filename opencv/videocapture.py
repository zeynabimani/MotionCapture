import numpy as np
import cv2 as cv
cap = cv.VideoCapture(0)
cap1 = cv.VideoCapture(1)
# Define the codec and create VideoWriter object
fourcc = cv.VideoWriter_fourcc(*'XVID')
width = int(cap1.get(cv.CAP_PROP_FRAME_WIDTH))
height = int(cap1.get(cv.CAP_PROP_FRAME_HEIGHT))

counter=1
while(1):
    ret1, frame1 = cap.read()
    ret2,frame2=cap1.read()
    path = 'check/2/' + str(counter) + '_'
   out = cv.VideoWriter(path+'output1.avi', fourcc, 30.0, (width,  height))
   out1 = cv.VideoWriter(path+'output2.avi', fourcc, 30.0, (width,  height))
    if not ret1:
        print("Can't receive frame1 (stream end?). Exiting ...")
        break
   if not ret2:
        print("Can't receive frame2 (stream end?). Exiting ...")
        break
    if ret1:
        frame1 = cv.flip(frame1, 0)
        # write the flipped frame1
        out.write(frame1)
        cv.imshow('frame1', frame1)
    if ret2:
        frame2 = cv.flip(frame2, 0)
        # write the flipped frame2
        out1.write(frame2)
        cv.imshow('frame2', frame2)
    if cv.waitKey(1) == ord('q'):
            break
    # Release everything if job is finished
   counter=counter+1
cap.release()
out.release()
cap1.release()
out1.release()
cv.destroyAllWindows()