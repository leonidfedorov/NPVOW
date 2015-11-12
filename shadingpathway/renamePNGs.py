from os import listdir, rename
from re import findall
from sys import argv

script, folder, echo = argv

old_filenames = listdir(folder)

if int(echo) == 1:
	print '***ALL ORIGINAL FILENAMES***\n'
	print old_filenames
	print "\n"

frame_numbers = map(lambda x : int(findall('\d+', x)[0]) + 1, old_filenames)
if int(echo) == 1:
	print '***ALL EXTRACTED FRAME NUMBERS***\n'
	print frame_numbers
	print "\n"

map(lambda x : rename(folder + x[0], folder + str(x[1]) +'.png'), zip(old_filenames, frame_numbers))

