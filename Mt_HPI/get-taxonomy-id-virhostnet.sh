#!/bin/bash
credit="#This get-taxonomy-id.sh program is created by rakesh from crddmirror system on Thu 12 Nov 2020 07:42:52 PM IST.\
#License: Attribution-NonCommercial-ShareAlike 4.0 International. For feedback, please email at rakesh4osdd@gmail.com"

mitab_file=$1
# taxid filename
#taxidfile=$1
taxidfile="taxid.human.$mitab_file"


# taxid file with single id number in each line
#taxidfile='id.taxid.path.human.hpidb2.mitab.txt'

if [ $# -ne 1 ] || [ ! -f "$mitab_file" ]
then
        [ ! -f "$mitab_file" ] &&  echo -e "$mitab_file input file not exists.\n"
        echo -e "Uses: $0 <taxidfile>\n "
        echo -e "$credit"
else

	# start time
	echo "Taxonomy search is started `date`"

	# get the uniq taxonomy id from psi-mitab 2.5 format for human
	grep  'taxid:9606' $mitab_file|cut -f10,11|tr '\t' '\n'|sort|uniq -c|cut -f2 -d':'|sort -n  > $taxidfile
	
	results_xml=`basename $taxidfile .txt`.xml
	
	results=`basename $results_xml .xml`.tsv
	
	taxids=`cat $taxidfile | tr '\n' ','`
	
	#echo $results_xml, $results #$taxids
	echo " Total number of lines and size of input file: `wc -l $taxidfile` | `du -sh $taxidfile` "
	
	# collect the data as xml file
	
	# parse the xml file
	efetch -db taxonomy -id $taxids -format xml > $results_xml
	
	#cat results.samples3.taxid.txt.xml | xtract -pattern Taxon -element TaxId ScientificName GenbankCommonName Division > $results
	cat $results_xml | xtract -pattern Taxon -element TaxId ScientificName GenbankCommonName Division > $results
	
	echo "Output Result Files stats:"
	du -sh $results_xml $results
	wc -l $results_xml $results
	
	echo "Total Bacteria and Viruses:"
	grep "Bacteria$" $results|cut -f1 > "Bacteria.$taxidfile"
	grep "Viruses$" $results|cut -f1 > "Viruses.$taxidfile"
	wc -l "Bacteria.$taxidfile" "Viruses.$taxidfile"
	
	echo "Taxonomy search is completed `date`"
fi
