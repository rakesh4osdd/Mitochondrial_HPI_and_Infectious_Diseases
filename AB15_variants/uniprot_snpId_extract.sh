#!/bin/bash

echo "`date` - dbSNP Terms search program is started"
#split file into length 7000 or less
uid_gene='AB-15_mt-protein-UniProt_GeneName.txt1'
#out='snpId'
#split -l 7000 $file  $out

#wc -l $out*
#wc -l $file

#for file in $(ls $out*)
#for file in $(tail $uid_gene|tr '\t' '_')
for file in $(tail -n+2 $uid_gene|tr '\t' '_')
do
	echo $file
	# export path
	export PATH=~/bin/edirect/:$PATH
	name=$file.id
	#
#	echo " Number of rsid in file = `wc -l $FILE`"
	#       change the output file path for xtract command
	output='rsids_output'
	#mkdir -p $output/{found,not_found,results}
	mkdir -p $output
	gene_name=`echo $file |cut -f2 -d '_'| tr -d '\n'`
	#efetch -db snp -query "$gene_name[GENE]" > $output/$name.xml
	esearch -db snp -query "$gene_name[GENE]" |efetch  -format xml > $output/$name.xml
	#cat $output/$name.xml | xtract -pattern DocumentSummary -element SNP_ID CHRPOS ALLELE  DOCSUM > $output/$name.tsv
	cat $output/$name.xml | xtract -pattern DocumentSummary -element SNP_ID DOCSUM > $output/$name.tsv &
	#echo $file, $name, $gene_name
done
echo "`date` - dbSNP Terms search program is ended"

cd $output
mkdir tsv_files
cp -a *.tsv tsv_files
# add uniprot and dbsnp_id in each rsid
cp ../fileloop.sh tsv_files
cd tsv_files
./fileloop.sh
#cat snpIda*.tsv  > $file.tsv
#wc -l  $file.tsv

#sed -i 's/^/rs/g' $file.tsv

