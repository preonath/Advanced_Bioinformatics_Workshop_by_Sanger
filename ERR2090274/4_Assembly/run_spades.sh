set -e
true
true
/SPAdes-3.15.5-Linux/bin/spades-hammer /data/ERR2090274_spades_assembly/corrected/configs/config.info
/usr/bin/python /SPAdes-3.15.5-Linux/share/spades/spades_pipeline/scripts/compress_all.py --input_file /data/ERR2090274_spades_assembly/corrected/corrected.yaml --ext_python_modules_home /SPAdes-3.15.5-Linux/share/spades --max_threads 8 --output_dir /data/ERR2090274_spades_assembly/corrected --gzip_output
true
true
/SPAdes-3.15.5-Linux/bin/spades-core /data/ERR2090274_spades_assembly/K21/configs/config.info /data/ERR2090274_spades_assembly/K21/configs/careful_mode.info
/SPAdes-3.15.5-Linux/bin/spades-core /data/ERR2090274_spades_assembly/K33/configs/config.info /data/ERR2090274_spades_assembly/K33/configs/careful_mode.info
/SPAdes-3.15.5-Linux/bin/spades-core /data/ERR2090274_spades_assembly/K55/configs/config.info /data/ERR2090274_spades_assembly/K55/configs/careful_mode.info
/usr/bin/python /SPAdes-3.15.5-Linux/share/spades/spades_pipeline/scripts/copy_files.py /data/ERR2090274_spades_assembly/K55/before_rr.fasta /data/ERR2090274_spades_assembly/before_rr.fasta /data/ERR2090274_spades_assembly/K55/assembly_graph_after_simplification.gfa /data/ERR2090274_spades_assembly/assembly_graph_after_simplification.gfa /data/ERR2090274_spades_assembly/K55/final_contigs.fasta /data/ERR2090274_spades_assembly/contigs.fasta /data/ERR2090274_spades_assembly/K55/first_pe_contigs.fasta /data/ERR2090274_spades_assembly/first_pe_contigs.fasta /data/ERR2090274_spades_assembly/K55/strain_graph.gfa /data/ERR2090274_spades_assembly/strain_graph.gfa /data/ERR2090274_spades_assembly/K55/scaffolds.fasta /data/ERR2090274_spades_assembly/scaffolds.fasta /data/ERR2090274_spades_assembly/K55/scaffolds.paths /data/ERR2090274_spades_assembly/scaffolds.paths /data/ERR2090274_spades_assembly/K55/assembly_graph_with_scaffolds.gfa /data/ERR2090274_spades_assembly/assembly_graph_with_scaffolds.gfa /data/ERR2090274_spades_assembly/K55/assembly_graph.fastg /data/ERR2090274_spades_assembly/assembly_graph.fastg /data/ERR2090274_spades_assembly/K55/final_contigs.paths /data/ERR2090274_spades_assembly/contigs.paths
true
true
/usr/bin/python /SPAdes-3.15.5-Linux/share/spades/spades_pipeline/scripts/correction_iteration_script.py --corrected /data/ERR2090274_spades_assembly/contigs.fasta --assembled /data/ERR2090274_spades_assembly/misc/assembled_contigs.fasta --assembly_type contigs --output_dir /data/ERR2090274_spades_assembly --bin_home /SPAdes-3.15.5-Linux/bin
/usr/bin/python /SPAdes-3.15.5-Linux/share/spades/spades_pipeline/scripts/correction_iteration_script.py --corrected /data/ERR2090274_spades_assembly/scaffolds.fasta --assembled /data/ERR2090274_spades_assembly/misc/assembled_scaffolds.fasta --assembly_type scaffolds --output_dir /data/ERR2090274_spades_assembly --bin_home /SPAdes-3.15.5-Linux/bin
true
/usr/bin/python /SPAdes-3.15.5-Linux/share/spades/spades_pipeline/scripts/breaking_scaffolds_script.py --result_scaffolds_filename /data/ERR2090274_spades_assembly/scaffolds.fasta --misc_dir /data/ERR2090274_spades_assembly/misc --threshold_for_breaking_scaffolds 3
true
