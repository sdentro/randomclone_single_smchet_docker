Pipeline for RandomClone methods that generate random subclonal reconstructions for SMC-het

## Building the image

Build the image as follows
```
docker build -t randomclone:0.1.0 .
```

## Running the pipeline

Run the pipeline from the commandline as follows (assuming a local directory named sample which contains the SMC-het available files for the sample to run)
```
docker run  -v `pwd`/sample:/opt/sample randomclone:0.1.0 bash -c "cd /opt/sample&& /opt/galaxy/tools/dpclust/randomclone_informed.sh sample.mutect.vcf 1 sample.battenberg.txt sample.cellularity_ploidy.txt male 1"
```

## Output

**SMC-het specific files**
```
subchallenge1A.txt
subchallenge1B.txt
subchallenge1C.txt
subchallenge2A.txt
subchallenge2B.txt
```

**Randomclone output**
```
tumour_mutation_assignments_probabilities.txt
tumour_mutation_assignments.txt
tumour_randomclone_informed_models.RData
tumour_randomclone_informed_selected_solution.RData
tumour_subclonal_structure.txt
```

**Intermediate and temporary files**
```
allDirichletProcessInfo.txt
alleleCounts.txt
loci.txt
temp_copynumber.txt
temp_rho_psi.txt
temp_snvs.vcf
```
