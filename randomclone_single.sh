#!/bin/bash
vcf=$1
samplenumber=$2
subclones=$3
rhopsi=$4

purity=`tail -n 1 ${rhopsi} | cut -f 1`
samplename="tumour"
rdpath="${HOME}/repo/randomclone/"
#rdpath="/opt/galaxy/tools/dpclust/randomclone/"
utilpath="${HOME}/repo/smchet_utils/"
#utilpath="/opt/galaxy/tools/dpclust/smchet_utils/"
PATH=${rdpath}:${PATH}
dpinput="allDirichletProcessInfo.txt"
Rscript ${utilpath}/run_preprocessing.R ${vcf} ${samplenumber} ${subclones} ${rhopsi}
Rscript ${rdpath}/randomclone_single.R ${rdpath} ${samplename} ${dpinput} ${purity} "simulated" ${PWD}
Rscript ${utilpath}/randomclone_smchet_output.R ${utilpath} ${subclones} ${vcf} ${samplename}_mutation_assignments.txt ${samplename}_subclonal_structure.txt

