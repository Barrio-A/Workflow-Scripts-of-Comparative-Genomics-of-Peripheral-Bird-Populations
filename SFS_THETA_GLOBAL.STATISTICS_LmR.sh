#!/bin/bash

pth_home=/PATH/DIRECTORY
pth_angsd=/PATH/angsd

pth_i=$pth_home/ANGSD_Results
pth_o=$pth_home/ANGSD_Results
i_name_prefix=LmR_angsd
o_name_prefix=LmR
threads=8

$pth_angsd/misc/realSFS \
    $pth_i/$i_name_prefix.saf.idx \
    -P $threads \
    > $pth_o/$o_name_prefix.sfs

$pth_angsd/misc/realSFS \
    saf2theta \
    $pth_i/$i_name_prefix.saf.idx \
    -outname $pth_o/$o_name_prefix.theta_all \
    -sfs $pth_o/$o_name_prefix.sfs

winsize=1000000

$pth_angsd/misc/thetaStat do_stat \
    $pth_i/$i_name_prefix.theta_all.thetas.idx \
    -win $winsize \
    -step $winsize \
    -outnames $pth_o/$o_name_prefix.win.gz \
    -type 2
