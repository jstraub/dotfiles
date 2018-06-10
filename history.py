#!/usr/bin/env python
import os
log =os.path.expanduser("~/.logs/bash-history-all.log")
for i,line in enumerate(open(log).readlines()):
  print "{}  {}".format(i,line),
