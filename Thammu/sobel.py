import numpy
import scipy
from scipy import ndimage

im = scipy.misc.imread('liver.jpg', flatten=1)
im = im.astype('int32')
dx = ndimage.sobel(im, 1)  # horizontal derivative
dy = ndimage.sobel(im, 0)  # vertical derivative
mag = numpy.hypot(dx, dy)  # magnitude
print mag
mag *= 255.0 / numpy.max(mag)  # normalize (Q&D)
scipy.misc.imsave('sobel.jpg', mag)