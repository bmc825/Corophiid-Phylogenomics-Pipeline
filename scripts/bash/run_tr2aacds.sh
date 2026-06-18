#! /bin/bash
## RUN-LOCAL: env trset=04_Photidae_B.tr.gz datad=`pwd` ./run_tr2aacds.sh >& log.tr2ac1

function okapp {
  which $1 > /dev/null
  if [ $? -ne 0 ]; then echo Missing bioapp: $1; usage; fi
  return 1;
}

# EDIT THIS path: bapps=/YOUR/PATH/TO/bio_applications for evigene,ncbi,exonerate,cdhit
bapps=/usr/local/evigene19may14/bio/apps
evigene=/usr/local/evigene19may14/evigene;
export PATH=$bapps/cdhit/bin:$PATH
export PATH=$bapps/exonerate/bin:$PATH
export PATH=$bapps/ncbi/bin/blastn:$PATH

if [ X = "X$trset" ]; then echo "Missing env trset=xxxx.tr"; usage; fi
if [ X = "X$datad" ]; then echo "Missing env datad=/path/to/data"; usage; fi
if [ X = X$ncpu ]; then ncpu=2; fi
if [ X = X$maxmem ]; then maxmem=1000; fi

okapp blastn;
okapp fastanrdb;
okapp cd-hit-est;
okapp $evigene/scripts/prot/tr2aacds.pl

cd $datad/

echo $evigene/scripts/prot/tr2aacds.pl -tidy -NCPU $ncpu -MAXMEM $maxmem -log -cdna $trset
$evigene/scripts/prot/tr2aacds.pl -tidy -NCPU $ncpu -MAXMEM $maxmem -log -cdna $trset
