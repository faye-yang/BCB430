# Author: Prof.Hannes Rost
# Perform extraction for different RT extraction windows

# TODO use the 160 s decoy data to run through (instead of the random decoy data
)

# Test data
# {{{
swath_window=7
OSWDIR=/home/hroest/hroest/lib/openms/builds/metaboswath_build/bin/
library=../data/DDA_consensus_library_pos_decoy.csv
file=../data/nus/AMD_data/converted/positive/CS56148_pos_SWATH-CS56148.mzML.gz


## 3.5 GB max mem ... 
qsub -pe shm 4 -cwd -l h_vmem=3G -l h_rt=2:00:00 -j y -b y -w e -N testrun2 \
$OSWDIR/OpenSwathWorkflow -in $file -tr $library -out_chrom ../results/testout_9
900.mzML \
    -out_tsv ../results/testout_9900.csv \
    -use_ms1_traces -Scoring:TransitionGroupPicker:min_peak_width 2.0 -Scoring:S
cores:use_rt_score true \
    -rt_extraction_window 9900 -min_upper_edge_dist 1 -Scoring:rt_normalization_
factor 1200 -threads 4



module load python
# pip install --user pyprophet # installs into ~/.local/bin/
pyprophet --ignore.invalid_score_columns  results/testout_10.csv
# 1    0.01  0.745174  0.049656   938    9  181.798343   320.201657  0.010004  0.745508  1.727396
# 3    0.05  0.991449  0.343102  1248   65  125.798343    10.201657  0.049861  0.991892  0.413028

pyprophet --ignore.invalid_score_columns  results/testout_15.csv
# 1    0.01  0.888331  0.074305  1448   15  181.77437   182.22563  0.009995  0.888221   1.509982
# 3    0.05  1.000000  0.439231  1634   86  110.77437    -3.77437  0.050245  1.000000   0.131846

pyprophet --ignore.invalid_score_columns  results/testout_20.csv
# 1    0.01  0.948467  0.157351  1633   16   88.781433    88.218567  0.009998  0.948746  1.097343
# 3    0.05  1.000000  0.861541  1728   90   14.781433    -6.781433  0.049656  1.000000 -1.012431

pyprophet --ignore.invalid_score_columns  results/testout_25.csv
# 1    0.01  0.956579  0.158689  1647   17   87.723987    75.276013  0.009986  0.956293   1.095211
# 3    0.05  1.000000  0.855869  1728   90   14.723987    -5.723987  0.049296  1.000000  -0.969403

pyprophet --ignore.invalid_score_columns  results/testout_30.csv
# 1    0.01  0.939108  0.142300  1612   16   98.729326   104.270674  0.010028  0.939246  1.167723
# 3    0.05  1.000000  0.782159  1721   90   24.729326    -4.729326  0.049551  1.000000 -1.048622

pyprophet --ignore.invalid_score_columns  ../results/testout_35.csv
# 1    0.01  0.919218  0.080471  1518   15  175.103261   132.896739  0.009980  0.919500  1.442012
# 3    0.05  1.000000  0.457431  1655   87  103.103261    -4.103261  0.049915  1.000000  0.091712


pyprophet --ignore.invalid_score_columns  results/testout_40.csv
# 1    0.01  0.897732  0.069197  1454   15  197.231694   165.768306  0.009998  0.897659  1.498982
# 3    0.05  1.000000  0.401990  1620   85  127.231694    -0.231694  0.050036  1.000000  0.126176


pyprophet --ignore.invalid_score_columns  results/testout_60.csv
# 1    0.01  0.835429  0.052048  1324   13  244.613043   260.386957  0.010028  0.835654  1.697847
# 3    0.05  0.991690  0.322092  1571   83  174.613043    13.386957  0.050160  0.991551  0.473710


pyprophet --ignore.invalid_score_columns  results/testout.csv # 80 sec extraction
# 1    0.01  0.794074  0.048455  1260   13  249.950938   327.049062  0.010009  0.793926  1.715963
# 3    0.05  0.987792  0.313781  1568   82  180.950938    19.049062  0.050000  0.987997  0.505278


pyprophet --ignore.invalid_score_columns  results/testout_180.csv
# 1    0.01  0.687463  0.035285  1067   11  294.662356   485.337644  0.010005  0.687350  1.895670
# 3    0.05  0.969491  0.258874  1505   79  226.662356    47.337644  0.049951  0.969506  0.702089




OSWDIR=/home/hroest/hroest/lib/openms/builds/metaboswath_build/bin/
library=../data/DDA_consensus_library_pos_decoy_rt.csv
file=../data/nus/AMD_data/converted/positive/CS56148_pos_SWATH-CS56148.mzML.gz
## 3.5 GB max mem ... 
## rt = random transition
qsub -pe shm 4 -cwd -l h_vmem=3G -l h_rt=2:00:00 -j y -b y -w e -N testrun2 \
$OSWDIR/OpenSwathWorkflow -in $file -tr $library -out_chrom ../results/testout_librt_9900.mzML \
    -out_tsv ../results/testout_librt_9900.csv \
    -use_ms1_traces -Scoring:TransitionGroupPicker:min_peak_width 2.0 -Scoring:Scores:use_rt_score true \
    -rt_extraction_window 9900 -min_upper_edge_dist 1 -Scoring:rt_normalization_factor 1200 -threads 4

pyprophet --ignore.invalid_score_columns  ../results/testout_librt_9900.csv

pyprophet --ignore.invalid_score_columns  ../results/testout_librt_300.csv
# 1    0.01  0.974501  1.515349e-01  1707   17   96.394134    44.605866  0.009966  0.974534   

pyprophet --ignore.invalid_score_columns  ../results/testout_librt_100.csv
# 1    0.01  0.974578  0.168154  1707   17   84.388049    44.611951  0.009888  0.974531  1.068424

pyprophet --ignore.invalid_score_columns  ../results/testout_librt_30.csv
# 1    0.01  0.998649  0.263684  1764  17  47.702004     2.297996  0.009580  0.998699  0.771526





OSWDIR=/home/hroest/hroest/lib/openms/builds/metaboswath_build/bin/
library=../data/DDA_consensus_library_pos_decoy_160s.csv
file=../data/nus/AMD_data/converted/positive/CS56148_pos_SWATH-CS56148.mzML.gz
## rrt = random RT
RT_SECONDS=80
qsub -pe shm 4 -cwd -l h_vmem=3G -l h_rt=2:00:00 -j y -b y -w e -N testrun2 \
$OSWDIR/OpenSwathWorkflow -in $file -tr $library -out_chrom ../results/testout_librrt_${RT_SECONDS}.mzML \
    -out_tsv ../results/testout_librrt_${RT_SECONDS}.csv \
    -use_ms1_traces -Scoring:TransitionGroupPicker:min_peak_width 2.0 -Scoring:Scores:use_rt_score true \
    -rt_extraction_window ${RT_SECONDS} -min_upper_edge_dist 1 -Scoring:rt_normalization_factor 1200 -threads 4


pyprophet --ignore.invalid_score_columns  ../results/testout_librrt_9900.csv
# 1    0.01  0.910126  0.091920  1545   16  154.182208   152.817792  0.010022  0.909992  1.473780
# 3    0.05  1.000000  0.532023  1708   91   79.182208   -10.182208  0.050325  1.000000 -0.043110

pyprophet --ignore.invalid_score_columns  --target.overwrite ../results/testout_librrt_300.csv
# 1    0.01  0.921379  0.076940  1534   15  185.77432   130.22568  0.009974  0.921750  1.480883
# 3    0.05  1.000000  0.441265  1670   88  112.107296    -5.107296  0.050224  1.000000  0.219240

pyprophet --ignore.invalid_score_columns  --target.overwrite ../results/testout_librrt_100.csv
# 1    0.01  0.927275  0.073406  1524   15  195.113391   118.886609  0.010023  0.927636  1.512781
# 3    0.05  1.000000  0.433610  1656   87  113.107991    -3.107991  0.049783  1.000000  0.162885

pyprophet --ignore.invalid_score_columns  --target.overwrite ../results/testout_librrt_60.csv
# 1    0.01  0.943131  0.076986  1546   16  186.219565    93.780435  0.009966  0.942809  1.455523
# 3    0.05  1.000000  0.428169  1644   87  115.219565    -4.219565  0.050017  1.000000  0.170281

pyprophet --ignore.invalid_score_columns  --target.overwrite ../results/testout_librrt_30.csv
# 1    0.01  0.998681  0.260311  1760  18  50.037158     2.962842  0.009960  0.998319  0.860655
# 3    0.05  1.000000  9.996648e-01  1764  67  -0.296903     0.296903  3.641766e-02  0.999832




OSWDIR=/home/hroest/hroest/lib/openms/builds/metaboswath_build/bin/
library=../data/DDA_consensus_library_pos_decoy_randSwath.csv
library=../data/DDA_consensus_library_pos_decoy_randMZ.csv
file=../data/nus/AMD_data/converted/positive/CS56148_pos_SWATH-CS56148.mzML.gz
RT_SECONDS=30
qsub -pe shm 4 -cwd -l h_vmem=3G -l h_rt=2:00:00 -j y -b y -w e -N testrun2 \
$OSWDIR/OpenSwathWorkflow -in $file -tr $library -out_chrom ../results/testout_librmz_${RT_SECONDS}.mzML \
    -out_tsv ../results/testout_librmz_${RT_SECONDS}.csv \
    -use_ms1_traces -Scoring:TransitionGroupPicker:min_peak_width 2.0 -Scoring:Scores:use_rt_score true \
    -rt_extraction_window ${RT_SECONDS} -min_upper_edge_dist 1 -Scoring:rt_normalization_factor 1200 -threads 4



pyprophet --ignore.invalid_score_columns  --target.overwrite ../results/testout_librmz_30.csv


















/home/hr/openmsall/openms_builds/release_build/bin/OpenSwathWorkflow -in /media/data/tmp/tempdata/PH697119/PH697119openswath_tmpfile_${swath_window}.mzML /media/data/t
mp/tempdata/PH697119/PH697119openswath_tmpfile_ms1.mzML  -tr results/DDA_consensus_library_pos_decoy.csv  -out_chrom results/with_dc/pos_lib_testout_swath_xx_${swath_w
indow}.mzML  -use_ms1_traces -out_tsv results/with_dc/pos_withrt_wf_swath_xx__${swath_window}.csv -Scoring:TransitionGroupPicker:min_peak_width 2.0 -debug 0 -Scoring:S
cores:use_rt_score true -rt_extraction_window 80 -min_upper_edge_dist 1 -Scoring:rt_normalization_factor 1200


qsub -pe shm 4 -cwd -l h_vmem=3G -l h_rt=2:00:00 -j y -b y -w e -N testru4 ./src/run_osw.sh $file $library /home/hroest/hroest/lib/openms/source/OpenMS_metaboswath/src
/tests/topp/OpenSwathWorkflow_1_input.TraML testoutput__x 4



# }}}
[yangyu35@gra-login1 convert]$ vi control.sh 

mv ../results/r_300/PH697053_pos_SWATH-PH697053_with_dscore.csv ../results/r_300/bad/
mv ../results/r_300/PH697119_pos_SWATH-PH697119_with_dscore.csv ../results/r_300/bad/
mv ../results/r_300/PH697184_pos_SWATH-PH697184_with_dscore.csv ../results/r_300/bad/
mv ../results/r_300/PH697338_pos_SWATH-PH697338_with_dscore.csv ../results/r_300/bad/

## extra bad run ... 
mv ../results/r_300/CS61791_pos_SWATH-CS61791_with_dscore.csv ../results/r_300/bad/


mkdir ../results/r_80/bad
mv ../results/r_80/PH697053_pos_SWATH-PH697053_with_dscore.csv ../results/r_80/bad/
mv ../results/r_80/PH697119_pos_SWATH-PH697119_with_dscore.csv ../results/r_80/bad/
mv ../results/r_80/PH697184_pos_SWATH-PH697184_with_dscore.csv ../results/r_80/bad/
mv ../results/r_80/PH697338_pos_SWATH-PH697338_with_dscore.csv ../results/r_80/bad/

## extra bad run ... 
mv ../results/r_80/CS61791_pos_SWATH-CS61791_with_dscore.csv ../results/r_80/bad/

# }}}

# run for 80 seconds 
/home/hroest/hroest/lib/msproteomicstools_exp/analysis/alignment/feature_alignment.py --in ../results/r_80/*with_dscore.csv --out ../results/r_80/aligned.csv --out_meta ../results/r_80/aligned.yaml --out_matrix ../results/r_80/aligned.mat.csv --method LocalMST --realign_method SmoothLLDMedian --max_rt_diff 10 --mst:useRTCorrection True --mst:Stdev_multiplier 3.0  --target_fdr 0.01 --max_fdr_quality 0.05 --alignment_score 0.01  --dscore_cutoff 0.0


## 16033_C8H7NO
## 1451_C5H4O4
## 1373_C17H22
## 1223_C46H82NO8P
## 1081_C25H50NO7P
