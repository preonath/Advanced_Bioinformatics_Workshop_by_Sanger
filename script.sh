############################################################### ok Setup Docker  ##################################################################
echo 'function docker_run() { docker run --rm=True -u $(id -u):$(id -g) -v $(pwd):/data "$@" ;}' >> ~/.bash_profile
source ~/.bash_profile


path="/home/preonath/Desktop/Data/Traning"
############################################################### ok Raw_Data ##############################################################################
## 1_RadData
# for file in $path/*
# do
# 	name=`basename $file| cut -f 1 -d "_"`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name 
# 		mkdir -p -v $path/$name/1_RawData
# 		mv $file $path/$name/1_RawData
# 	fi
# done


############################################################### ok QC ##############################################################################

# 2_QC check. 
# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		mkdir -p -v $dir/2_FastQC 
# 		cd $dir/1_RawData/ && docker_run staphb/fastqc fastqc $name\_*.fastq.gz 
# 		mv $dir/1_RawData/*_fastqc.html $dir/1_RawData/*_fastqc.zip $dir/2_FastQC 

# 		remove unknow directory within rawdata folder
# 		rm -rf $dir/1_RawData/?
# 	fi
# done

############################################################### ok Trimming ##############################################################################

# # 3_Trimmomatic
adapters_path="$path/Adapter_trimming/adapters"/
for dir in $path/*
do
	name=`basename $dir`
	if [[ "$name" =~ ^ERR.* ]]; then
		echo $name
	# 	mkdir -p -v $dir/3_Trimming

	# 	cd $dir/1_RawData && docker_run staphb/trimmomatic trimmomatic PE $name\_1.fastq.gz $name\_2.fastq.gz $name\_1.trimmed.fastq.gz /dev/null $name\_2.trimmed.fastq.gz /dev/null ILLUMINACLIP:$adapters_path/TruSeq3-PE-2.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:36 LEADING:20 TRAILING:20
	# 	mv $dir/1_RawData/*trimmed.fastq.gz $dir/3_Trimming

	# fi
	break
done;


############################################################### ok Assembly ##############################################################################


#4_Assembly

# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		mkdir -p -v $dir/4_Assembly

# 		cd $dir/3_Trimming && docker_run staphb/spades spades.py -1 $name\_1.trimmed.fastq.gz -2 $name\_2.trimmed.fastq.gz --careful --cov-cutoff auto -o $name\_spades_assembly -t 8 
# 		mv $dir/3_Trimming/$name\_spades_assembly/* $dir/4_Assembly
# 		rm -rf $dir/3_Trimming/$name\_spades_assembly
# 		mv $dir/4_Assembly/contigs.fasta $dir/4_Assembly/$name\_contigs.fasta
# 	fi
# done


############################################################### ok Kraken ##############################################################################


# # 5_Kraken
# kraken="/home/preonath/Desktop/Data/Traning/Kraken"
# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		mkdir -p -v $dir/5_Kraken
# 		cp $dir/3_Trimming/*.trimmed.fastq.gz $kraken/
# 		cd $kraken\/ && docker_run staphb/kraken2 kraken2 --threads 12 --use-names --db k2_standard_08gb_20221209 --paired $name\_1.trimmed.fastq.gz $name\_2.trimmed.fastq.gz --report $name\_kraken_report.txt --output - --memory-mapping
# 		rm -rf $kraken\/$name\_*.trimmed.fastq.gz
# 		mv $kraken/$name\_kraken_report.txt $dir/5_Kraken
# 		grep "Streptococcus agalactiae" $dir/5_Kraken/$name\_kraken_report.txt 
# 		# echo $name
# 		# bash $kraken/percentage_calculator.sh $dir/5_Kraken/$name\_kraken_report.txt
# 	fi
# done


############################################################### ok Prokka ##############################################################################


# 6_Prokka

# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		mkdir -p -v $dir/6_Prokka
# 		cp $dir/4_Assembly/$name\_contigs.fasta $dir/6_Prokka
# 		cd $dir/6_Prokka/ && docker_run staphb/prokka:latest prokka $name\_contigs.fasta 
# 		rm -rf $dir/6_Prokka/$name\_contigs.fasta
# 	fi
# done

############################################################### ok Quast ##############################################################################

# 7_Quast
# Ref="/home/preonath/Desktop/Data/Traning/References"
# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		mkdir -p -v $dir/7_Quast
# 		cp $dir/1_RawData/*.fastq.gz $dir/7_Quast
# 		cp $dir/4_Assembly/$name\_contigs.fasta $dir/7_Quast/
# 		cp $dir/6_Prokka/PROKKA_02182023/PROKKA_02182023.gff $dir/7_Quast/
# 		cp $Ref/Reference_sequence_GPSC46.fa $dir/7_Quast/
# 		cd $dir/7_Quast/ &&  docker_run staphb/quast quast.py $name\_contigs.fasta -g PROKKA_02182023.gff -1 $name\_1.fastq.gz -2 $name\_2.fastq.gz -o $name\_quast_output
# 		rm -rf $dir/7_Quast/$name\_contigs.fasta
# 		rm -rf $dir/7_Quast/PROKKA_02172023.gff
# 	fi
# done


############################################################### ok Seroba ##############################################################################
#8_Seroba

# seroba_db="/home/preonath/Desktop/Data/Traning/Seroba/s.pneumoniae/seroba_k71_14082017/"

# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		mkdir -p -v $dir/8_Seroba
# 		cp -r $seroba_db $dir/8_Seroba/
# 		cp $dir/1_RawData/*.fastq.gz $dir/8_Seroba/
# 		cd $dir/8_Seroba/ && docker_run staphb/seroba seroba runSerotyping seroba_k71_14082017 $name\_1.fastq.gz $name\_2.fastq.gz $name\_output_seroba
# 		rm -rf $dir/8_Seroba/seroba_k71_14082017
# 		rm -rf $dir/8_Seroba/*.fastq.gz

# 	fi
# done


############################################################### ok SRST ##############################################################################


#9_SRST
# srst_db="/home/preonath/Desktop/Data/Traning/Seroba/s.agalactiae/GBS-SBG"
# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		mkdir -p -v $dir/9_SRST
# 		cp -r $srst_db $dir/9_SRST/
# 		cp $dir/1_RawData/*.fastq.gz $dir/9_SRST/
# 		cd $dir/9_SRST/ && docker_run staphb/srst2 srst2 --input_pe $name\_1.fastq.gz $name\_2.fastq.gz --output $name\_srst_output --log --gene_db GBS-SBG/GBS-SBG.fasta
# 		rm -rf $dir/9_SRST/GBS-SBG
# 		rm -rf $dir/9_SRST/*.fastq.gz
# 	fi
# done


############################################################### MLST Read ok ##############################################################################
#10_MLST

# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name10_1_MLST_from_reads
# 		mkdir -p -v $dir/10_MLST/10_1_MLST_from_reads
# 		cd $dir/10_MLST/10_1_MLST_from_reads && docker_run staphb/srst2 getmlst.py --species "Streptococcus pneumoniae"
# 		cp $dir/1_RawData/*.fastq.gz $dir/10_MLST/10_1_MLST_from_reads
# 		cd $dir/10_MLST/10_1_MLST_from_reads && docker_run staphb/srst2 srst2 --input_pe $name\_1.fastq.gz $name\_2.fastq.gz  --output $name\_mlst --log --mlst_db Streptococcus_pneumoniae.fasta --mlst_definitions profiles_csv --mlst_delimiter _  --threads 8
#  		rm -rf $dir/9_SRST/GBS-SBG
#  		rm $dir/9_SRST/*.fastq.gz
# 		# break
# 	fi
# done

############################################################### MLST contigs ok ##############################################################################

#10_MLST

# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name10_1_MLST_from_reads
# 		mkdir -p -v $dir/10_MLST/10_2_MLST_from_contigs
# 		cp $dir/4_Assembly/$name\_contigs.fasta $dir/10_MLST/10_2_MLST_from_contigs
# 		cd $dir/10_MLST/10_2_MLST_from_reads && docker_run staphb/srst2 getmlst.py --species "Streptococcus pneumoniae"
# 		cd $dir/10_MLST/10_1_MLST_from_reads && docker_run staphb/srst2 srst2 --input_pe $name\_1.fastq.gz $name\_2.fastq.gz  --output $name\_mlst --log --mlst_db Streptococcus_pneumoniae.fasta --mlst_definitions profiles_csv --mlst_delimiter _  --threads 8
#  		# rm -rf $dir/9_SRST/GBS-SBG
#  		# rm $dir/9_SRST/*.fastq.gz
# 		break
# 	fi
# done



###############################################################  ok AMR ##############################################################################
# 11_AMR

# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		mkdir -p -v $dir/11_AMR
# 		cp $dir/4_Assembly/$name\_contigs.fasta $dir/11_AMR
# 		cd $dir/11_AMR && docker_run staphb/abricate abricate --db ncbi --quiet $name\_contigs.fasta > $name\_results.tab
#  		rm -rf $name\_contigs.fasta
# 	fi
# done


############################################################### Partially ok Snippy ##############################################################################




#12_Snippy

# Ref="/home/preonath/De/top/Data/Traning/List"
#Variant Calling
# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
		# mkdir -p -v $dir/12_Snippy 
		# cp $Ref/Reference_sequence_GPSC46.fa $dir/12_Snippy
		# cp $dir/1_RawData/*.fastq.gz $dir/12_Snippy
		# cd $dir/12_Snippy/ && docker_run staphb/snippy snippy --outdir $name\_GPSC46_result --R1 $name\_1.fastq.gz --R2 $name\_2.fastq.gz --ref Reference_sequence_GPSC46.fa --force --quiet
		# mkdir -p -v $dir/12_Snippy/multiple_files
		# cp $dir/1_RawData/*.fastq.gz $dir/12_Snippy/multiple_files
		# cp $listt/list.txt $dir/12_Snippy/multiple_files
		# rm -rf $dir/12_Snippy/multiple_files/list.txt
		# cd $dir/12_Snippy/multiple_files && docker_run staphb/snippy snippy-multi list.txt --ref Reference_sequence_GPSC46.fa --cpus 2 > runme.sh


# 		cp $Ref/Reference_sequence_GPSC46.fa $dir/12_Snippy/Variant_calling/multiple_files
# 		cd $dir/12_Snippy/Variant_calling/multiple_files/ && docker_run staphb/snippy snippy-multi list.txt --ref Reference_sequence_GPSC46.fa --cpus 2 > runme.sh
# 		cd $dir/12_Snippy/Variant_calling/multiple_files/



#		rm  $dir/12_Snippy/*.fastq.gz
		
# 	fi
# done




# cat /home/preonath/Desktop/Data/Traning/ERR*/6_Prokka/PROKKA\_*/PROKKA\_*.txt > /home/preonath/Desktop/Data/Traning/Presentation/prokka.txt
# AMR

# for dir in $path/*
# do
# 	name=`basename $dir`
# 	if [[ "$name" =~ ^ERR.* ]]; then
# 		echo $name
# 		cat $dir/8_Seroba/$name\_output_seroba/pred.tsv /home/preonath/Desktop/Data/Traning/Serobaa/out.tsv
# # 		cd $dir/11_AMR && docker_run staphb/abricate abricate --db ncbi --quiet $name\_contigs.fasta > $name\_results.tab
# #  		rm -rf $name\_contigs.fasta
# 	fi
# done


























