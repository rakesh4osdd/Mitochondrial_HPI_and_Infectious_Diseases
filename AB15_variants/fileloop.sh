#!/bin/bash
# add uniprot id and gene name in each rsid
#for file in $(ls *.tsv2)
for file in $(ls *.tsv)
do
	#command1 on $OUTPUT
	#command2 on $OUTPUT
	#commandN
	uid=`echo $file|cut -f1 -d '_'`
	gene_name=`echo $file|cut -f1 -d'.'|cut -f2 -d'_'`
	add_data=`echo "$uid\t$gene_name\trs"`
	echo $add_data
	#cat $file
	sed -i "s/^/$add_data/g" $file	
done

cat *.tsv > ../../AB-15_mt-protein-UniProt_GeneName.tsv
