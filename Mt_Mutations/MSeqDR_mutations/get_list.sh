#!/bin/bash

# list of 982 uniprot id without isoform
cut -f2 NCBI_Protein_ID_uniprot_ids_5778.txt |sort -u|grep -f uniprot_2778_list.txt --color|cut -f1 -d'-'|sort -u|wc -l

# list of 2009 uniprot id with isoform
cut -f2 NCBI_Protein_ID_uniprot_ids_5778.txt |sort -u|grep -f uniprot_2778_list.txt --color|sort -u|wc -l

##list of 2 uniprot isoform found in both
# get list of isoform in 2778 uniprot
grep '-' uniprot_2778_list.txt  > uniprot_2778_list_28isoform.txt
#find this list in NCBI_Protein_ID_uniprot_ids_5778.txt
grep -w -f uniprot_2778_list_28isoform.txt NCBI_Protein_ID_uniprot_ids_5778.txt

#get list of 982 uniprot + 2 isoform = 984 uniprot ids with isoform
cut -f2 NCBI_Protein_ID_uniprot_ids_5778.txt |sort -u|grep -f uniprot_2778_list.txt --color|cut -f1 -d'-'|sort -u > NCBI_Protein_ID_uniprot_ids_984.txt
grep -w -f uniprot_2778_list_28isoform.txt NCBI_Protein_ID_uniprot_ids_5778.txt | cut -f2 >> NCBI_Protein_ID_uniprot_ids_984.txt

#count the rows
wc -l NCBI_Protein_ID_uniprot_ids_984.txt

# get the 984 list using script 
./get_match_without_hyphen.sh uniprot_2778_list.txt NCBI_Protein_ID_uniprot_ids_5778.txt > NCBI_Protein_ID_uniprot_ids_5778_tr_ids1788.txt
wc -l NCBI_Protein_ID_uniprot_ids_5778_tr_ids1788.txt


# get 709 mutations against UniProt ids and postions given in MSeqDR variants file
grep -w -f NCBI_Protein_ID_uniprot_ids_5778_id735.txt ../../mutations.tsv |grep -w -f protein_pos.txt > NCBI_Protein_ID_uniprot_ids_5778_id735_pos_mutations.txt
wc -l NCBI_Protein_ID_uniprot_ids_5778_id735_pos_mutations.txt


# get 178 disease list
tail -n +2 gene284_variants18976_ncbi_id1780.tsv|cut -f9|tr ',' '\n'|sort -u|grep -v '^-' > disease178_gene284_variants18976_ncbi_id1780.tsv
wc -l disease178_gene284_variants18976_ncbi_id1780.tsv


# get 735 uniprot search in mutations.tsv to get 2786 mutations interaction
#head -n1  ../../mutations.tsv  > NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt
#grep -w -f NCBI_Protein_ID_uniprot_ids_5778_id735.txt ../../mutations.tsv >> NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt


# run python script and get 2187 split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt without self interaction

# filter the parse file though python script

# remove inteactions of others than human for bacteria and virus | grep -v 'Chemical\|\frog\|Chicken\|Saccharomyces\|taurus\|Chlorocebus\|Cricetulus\|Canis\|musculus\|Rattus'
grep -v 'Chemical\|\frog\|Chicken\|Saccharomyces\|taurus\|Chlorocebus\|Cricetulus\|Canis\|musculus\|Rattus' split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt > human1897_split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt 

# search 984 uniprot id in human1897_split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt
cut -f2 human1897_split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt | grep -f NCBI_Protein_ID_uniprot_ids_5778_id735.txt|sort -u|wc -l  
cut -f3 human1897_split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt | grep -f NCBI_Protein_ID_uniprot_ids_5778_id735.txt|sort -u|wc -l
cut -f8 human1897_split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt | grep -f NCBI_Protein_ID_uniprot_ids_5778_id735.txt|sort -u|wc -l


# get list of uniprot id find in protein variation column 8 in human1897_split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt
 grep 'P04637\|P51587' NCBI_Protein_ID_uniprot_ids_5778_tr_ids1788.txt |cut -f1> NCBI_Protein_ID_uniprot_ids_5778_tr_ids1788_tr9.txt


# get total 25 uniprot find back w.r.t. MSeqDR
cut -f2,3 human1897_split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations.txt|tr '\t' '\n'|grep -f NCBI_Protein_ID_uniprot_ids_5778_id735.txt|sort -u |sed 's/uniprotkb://g' > human1897_split_NCBI_Protein_ID_uniprot_ids_5778_id735_mutations_uniprot25.txt
