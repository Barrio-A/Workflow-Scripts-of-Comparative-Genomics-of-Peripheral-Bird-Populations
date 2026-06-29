#!/bin/bash

awk 'BEGIN{OFS="\t"}
{
    bin=int(($2-1)/1000000);
    key=$1"\t"bin;
    suma[key]+=$3;
    n[key]++;
}
END{
    for(k in suma){
        split(k,a,"\t");
        inicio=a[2]*1000000+1;
        fin=(a[2]+1)*1000000;
        print a[1],inicio,fin,suma[k]/n[k];
    }
}' LmR.depth.tsv | sort -k1,1 -k2,2n > LmR_depth.win_1Mb.tsv

awk '$1 ~ /^SUPER_/' LmR_depth.win_1Mb.tsv > LmR_depth.win_1Mb.SUPER.tsv


cut -f2,3,5,14 LmR.win.gz.pestPG | tr '\t' ',' > LmR_win.csv


awk -F',' 'BEGIN{OFS=","; print "Chr,WinCenter,tP_per_nSites"} \
NR>1 {
    if($4==0) print $1,$2,"NA";
    else print $1,$2,$3/$4
}' LmR_win.csv > LmR_tP.nSites.csv

awk -F',' 'BEGIN{OFS=","; print "Chr,WinCenter,tP_per_nSites,nSites"} \
NR>1 {
    if($4==0) print $1,$2,"NA";
    else print $1,$2,$3/$4,$4
}' LmR_win.csv > LmR_pi.nSites.csv

awk 'BEGIN{OFS=","}
{
    bin=int(($2-1)/1000000)
    key=$1","bin
    depth[key]=$4
}
END{
    for(k in depth){
        print k,depth[k]
    }
}' LmR_depth.win_1Mb.SUPER.tsv > LmR_depth.binned.csv


awk 'BEGIN{FS=OFS=","}

NR==FNR{
    depth[$1","$2]=$3
    next
}

FNR==1{
    print $0",depth"
    next
}

{
    key=$1","$5   # Chr + bin
    val = (key in depth ? depth[key] : "NA")
    print $0,val
}
' LmB_depth.binned.csv LmB_pi.nSites.binned.csv > LmB_pi.nSites.depth.csv

awk -F',' 'BEGIN{OFS=","}
NR==1{
    for(i=1;i<=NF;i++){
        if($i!="bin") col[i]=1
    }
}
{
    out=""
    for(i=1;i<=NF;i++){
        if(col[i]){
            out = (out=="" ? $i : out OFS $i)
        }
    }
    print out
}' LmB_pi.nSites.depth.csv > LmB_pi.nSites.depth_no.bin.csv
