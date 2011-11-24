#!/usr/bin/env python
# -*- coding:utf-8 -*-
#author:rikugun

import sys
import urllib
import os
from shutil import copyfile


HOSTS_URL='https://smarthosts.googlecode.com/svn/trunk/hosts'

LOCAL_HOSTS='/etc/hosts'

def main():
    """主函数"""
    #备份文件
    copyfile(LOCAL_HOSTS,'hosts.bak')
    with open(LOCAL_HOSTS,'aw') as hosts:
        hosts.write(os.linesep)
        #转义windows和unix的换行
        for line in urllib.urlopen(HOSTS_URL):
            hosts.write(line.strip()+os.linesep)

    print "success!"

if __name__ == '__main__':
    if len(sys.argv)>1:
        HOSTS_URL = sys.argv[1]
    main()
