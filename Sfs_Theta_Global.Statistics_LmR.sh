#!/bin/bash

i_name_prefix=LmR_angsd
o_name_prefix=LmR
threads=8

angsd/misc/realSFS \
    $i_name_prefix.saf.idx \
    -P $threads \
    > $o_name_prefix.sfs

angsd/misc/realSFS \
    saf2theta \
    $i_name_prefix.saf.idx \
    -outname $o_name_prefix.theta_all \
    -sfs $o_name_prefix.sfs

winsize=1000000

angsd/misc/thetaStat do_stat \
    $i_name_prefix.theta_all.thetas.idx \
    -win $winsize \
    -step $winsize \
    -outnames $o_name_prefix.win.gz \
    -type 2
