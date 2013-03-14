import os
import sys

if __name__== '__main__' : 

    if (len(sys.argv) < 3):
        print "Usage: MaskTheMap MAP MASK"
        print "   Ex: MAP:  ../SDIO_MPCHIP_MAP.txt"
        print "       MASK: ../SDIO_MPCHIP_MSK.txt"
        exit()
    
    mapfile = open(sys.argv[1], 'r')
    maskfile = open(sys.argv[2], 'r')
    
    map_list = []
    map_list = mapfile.read().split('\n')
    Map = []
    for line in map_list:
        dw_list = line.split(' ')
        for dw in dw_list:
            if dw != '':
                Map.append(dw[2:] + dw[:2])
    
    
    mask_list = []
    mask_list = maskfile.read().split('\n')
    Mask = []
    line = []
    for dwm in mask_list:
        if dwm != '':
            msb = int(dwm[0], 16) 
            lsb = int(dwm[1], 16)
            Mask.append((msb & 1) >> 0)
            Mask.append((msb & 2) >> 1)
            Mask.append((msb & 4) >> 2)
            Mask.append((msb & 8) >> 3)
            Mask.append((lsb & 1) >> 0)
            Mask.append((lsb & 2) >> 1)
            Mask.append((lsb & 4) >> 2)
            Mask.append((lsb & 8) >> 3)
    
    if ( len(Mask) != len(Map) ):
        print "Error!! The lenth is not equal."
    else:
        for i in range(0, len(Mask)):
            if (Mask[i] == 0 and Map[i] != 'FFFF'):
                print "Error!! The map and mask file is not consistent at 0x%X-th byte (%s)" % (i*2-0x10, Map[i])
        print "\nOK: The map and mask file is consistent.\n"
    
    masked_start = 0x0
    masked_end = 0x0
    efuse_start = 0x0
    efuse_end = 0x0
    total = 0
    
    for i in range(0, len(Map)):
        if (i == 0):
            pass

        if ( Mask[i] == 0 ):  # masked
            if (Mask[i-1] == 1 and i > 0): # previous one is NOT masked
                efuse_end = i-1
                efuse_start = efuse_start*2
                efuse_end = efuse_end*2 +1
                #print '0x%03X - 0x%03X [EFUSE] : Total %3d bytes.' % (efuse_start, efuse_end, efuse_end-efuse_start+1)
                total += efuse_end - efuse_start + 1
                masked_start = i
        elif (Mask[i] == 1):  # NOT masked
            if ( Mask[i-1] == 0 and i > 0): # previous one is masked
                masked_end = i-1
                masked_start = masked_start*2
                masked_end = masked_end*2 +1
                #print '0x%03X - 0x%03X [MASKED]: Total %3d bytes.' % (masked_start, masked_end, masked_end-masked_start+1)
                print 'et.MarkReadOnlyRange(0x%03X, 0x%03X);' % (masked_start, masked_end)
                total += masked_end - masked_start + 1
                efuse_start = i
    # post-processing
    if (Mask[i] == 0):
        masked_end = len(Map) - 1
        masked_start = masked_start*2
        masked_end = masked_end*2 +1
        #print '0x%03X - 0x%03X [MASKED]: Total %3d bytes.' % (masked_start, masked_end, masked_end-masked_start+1)
        print 'et.MarkReadOnlyRange(0x%03X, (int)(LogicalEfuseSizeWiFi-1));' % (masked_start)
        total += masked_end - masked_start + 1
    else:
        efuse_end = len(Map) - 1
        efuse_start = efuse_start*2
        efuse_end = efuse_end*2 +1
        #print '0x%03X - 0x%03X [EFUSE] : Total %3d bytes.' % (efuse_start, efuse_end, efuse_end-efuse_start+1)
        total += efuse_end - efuse_start + 1
    
    
    if ( total != len(Map)*2 ):
        print '\nError: Map length %3d bytes != Total %3d bytes' % (len(Map)*2, total)
    else:
        print '\nOK: Map length %3d bytes == Total %3d bytes' % (len(Map)*2, total)
    
    
    
