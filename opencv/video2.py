import numpy as np
import cv2

# Define the codec and create VideoWriter object

counter = 1598
out = None

while counter <= 2040:
    counter += 1
    print(counter)
    path = "res/"+str(counter)+"_5.jpg"
    print(path)
    frame = cv2.imread(path)
    if frame is None:
        break
    if counter == 1599:
        fourcc = cv2.VideoWriter_fourcc(*'XVID')
        out = cv2.VideoWriter('output.avi',fourcc, 20.0, (frame.shape[1],frame.shape[0]))

    out.write(frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release everything if job is finished
out.release()

cv2.destroyAllWindows()