#!/usr/bin/python
# -*- coding: utf-8 -*-

import PIL
from PIL import Image
import argparse
import getpass

if __name__ == "__main__":
  
  parser = argparse.ArgumentParser(description='Image Canvas Tool')
  parser.add_argument("-v", "--verbose", help="output verbosity", action="store_true")
  parser.add_argument("-n", "--image", help="image name, 'image.png'", required=True)
  parser.add_argument("-e", "--enlarge", help="enlarge canvas, with size (100,100)")
  parser.add_argument("-t", "--trim", help="trim image", action="store_true")
  args = parser.parse_args()

  
  tool_print_instruction("Arguments:")
  print args

  if args.verbose:
    print("verbosity turned on")

  if args.image:
    print "Image name is : ", args.image
    

  if args.trim:
    print "Will do Trim"

  if args.enlarge:
    print "Will do Enlarge"



