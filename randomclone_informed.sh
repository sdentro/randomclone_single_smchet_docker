#!/bin/bash -eu
vcf=$1
samplenumber=$2
subclones=$3
rhopsi=$4
sex=$5
nthreads=$6

R_EXEC="R"
#R_EXEC_ALT="R-3.3.0"
R_EXEC_ALT="R"
R_SCRIPT="Rscript"

purity=`tail -n 1 ${rhopsi} | cut -f 1`
samplename="tumour"
#rdpath="${HOME}/repo/randomclone/"
rdpath="/opt/galaxy/tools/dpclust/randomclone/"
#utilpath="${HOME}/repo/smchet_utils/"
utilpath="/opt/galaxy/tools/dpclust/smchet_utils/"
#mtimerpath="${HOME}/repo/MutationTime.R/"
mtimerpath="/opt/galaxy/tools/dpclust/MutationTime.R/"
PATH=${rdpath}:${PATH}
dpinput="allDirichletProcessInfo.txt"
ploidy=`${R_SCRIPT} ${utilpath}/get_ploidy.R ${subclones}`
wgd_status=`${R_SCRIPT} ${utilpath}/get_wgd_status.R ${subclones}`
${R_SCRIPT} ${utilpath}/transform_battenberg_to_icgc.R ${subclones} "temp_copynumber.txt"
${R_EXEC_ALT} --no-save --no-restore --vanilla -f ${utilpath}/transform_mutect_to_icgc.R --args ${vcf} "temp_snvs.vcf" "tumor"
${R_SCRIPT} ${utilpath}/run_preprocessing.R ${vcf} ${samplenumber} ${subclones} ${rhopsi}

#unset R_LIBS
#unset R_LIBS_USER
#R_LIBS_USER="~/R/x86_64-unknown-linux-gnu-library/3.3:/software/vertres/lib/R"
#export R_LIBS_USER

${R_EXEC_ALT} --no-save --no-restore --vanilla -f ${rdpath}/randomclone_informed.R --args ${rdpath} ${mtimerpath} ${samplename} ${dpinput} ${purity} "simulated" ${PWD} temp_copynumber.txt temp_snvs.vcf ${ploidy} ${sex} ${wgd_status} ${nthreads}
${R_SCRIPT} ${utilpath}/randomclone_smchet_output.R ${utilpath} ${subclones} ${vcf} ${samplename}_mutation_assignments.txt ${samplename}_subclonal_structure.txt

