# Note
- download files and patial data: git fork https://github.com/faye-yang/BCB430.git
- change file name and file path as needed in main and body function for all files as needed. Only ParsePassatotoOutput.py has use file path in the function body to check if a file exist.
- most of the files are parsers, script files not in passatuto and sirius might need to change file path.
- Passatuto2 and SIRIUS4 are in two docker containers


# Data files
-  Target Library file: DDA_consensus_library_pos.tsv
- DDA_decoy_library_reroot.txt: transition file for reroot  method
- DDA_decoy_library.txt: transition file for conditional peak method
- decoy_library_reroot.tsv: decoy library for reroot method
- conditionalPeak_library_decoy.tsv: decoy library for conditional peak method

## Data file of passatuto2
* contain all zip data files that is used for or outputed from passatuto2
- txt file for sirius:Passatuto2/fragmentationTree
- .Dot files from SIRUS:Passatuto2/tree_dot
- parsed .Dot files from .Dot file for Passatuto: Passatuto2/TreeDir
- source data from Passatuto2: Passatuto2/Data
- parsed .ms file for RandomPeaks and conditionalPeak method: Passatuto2/data2
- output data from reroot method from passatuto: Passatuto2/output_reroot
- output data from conditional peak method from passatuto2: Passatuto2/output_conditionalPeak
- dockerfile: a copy of docker file for building the docker image


# tools using (not included in the github but in gitter):
- SIRIUS:a tool that construct a fragmentation tree, script.sh to run sirius
- Passatuto2: a tool that construct decoy library using 4 methods,RandomPeaks, conditionalPeak, reroot, and Empirical-Bayes-
Approach(this appoarch can only support for the tool source data using method and database: MassBank,CosineDistance).

e.g. java -cp "lib/passatutto.jar:lib/json-1.0.jar:lib/commons-math3-3.4.1.jar:lib/trove4j-3.0.3.jar" DecoyDatabaseConstruction -target /data2 -out /outputRandom -method RandomPeaks -ppm 10 -ae 2


# script directoy:
### convert.py: a script from Prof. Hannes Rost that convert decoy library.
### control.sh:example command and output from Prof. Hannes Rost for running the OpenSwath and pyprophet
### script.sh: a bash script to run sirius.  Note: it must  in sirius/bin/ directory to work. the github version is just a copy. to run this file:  cd sirius/bin/ then  ./script.sh
### library2ms.py: a parser script that has many parsers
- goal:parse mass spectrometry library file (e.g.DDA_consensus_library_pos.tsv) to ms file for sirius and passatuto for RandomPeaks and conditionalPeak method and parse file from .dot to older version of SIRIUS .dot for reroot method.

- function:

1.parseLibMs:parse mass spectrometry library file e.g.DDA_consensus_library_pos.tsv passatuto for RandomPeaks and conditionalPeak method. 
* Need: mass spectrometry library file
- input: a line of the library file which contain infomation about molecule, that must contain: compound name, formula,parentmass
- output: a ms file of such molecule


2.parseLibMsSirius:parse library file (e.g. DDA_consensus_library_pos.tsv) to ms file for sirius
- input: a line of the library file which contain infomation about molecule, that must contain: compound name, formula,parentmass
- output: a ms file of such molecule that contain only the parentmass and the intensity


3.formatSirius: parse file from .dot to older version of SIRIUS .dot for reroot method
- input:a path to the dot file
- output: a dot file in a older verison of SIRIUS dot file.

### ParsePassatotoOutput.py: parse to the format that transition.py can recognize. Must run this before transition.py.

### transition.py: a decoy transition library file. Need to concatenate with target library to work for Pyprophet and OpenSwath for all decoy libraries after running this function.
 * e.g. cat conditionalPeak_library_reroot.tsv ../DDA_consensus_library_pos.tsv >> conditionalPead_decoy.tsv  .replace the file path as you need for all decoy library


# insturction/work flow:
Passatuto2 example command: java -cp "lib/passatutto.jar:lib/json-1.0.jar:lib/commons-math3-3.4.1.jar:lib/trove4j-3.0.3.jar" DecoyDatabaseConstruction -target /data2 -out /outputRandom -method RandomPeaks -ppm 10 -ae 2
SIRIUS4 example command:
sirius -f C20H19NO5 -2 demo-data/txt/chelidonine_msms2.txt demo-data/txt/chelidonine_msms2.txt
SIRIUS4 example script:

random/conditional peak: Library file(DDA_consensus_library_pos.tsv)->ms file(Passatuto2/data2) ->run passatuto2 -> output file (output_conditionalPeak)
reroot method: Library file(DDA_consensus_library_pos.tsv) -> txt file(Passatuto2/fragmentationTree) -> SIRIUS4 (output file:Passatuto2/tree_dot) --> parse dot file format(using formatSirius funtion of library2ms.py; output file:Passatuto2/TreeDir) -> output file( Passatuto2/output_reroot)


example fragmentation tree .dot file format
```
strict digraph {
v1 [label="C57H87O3\n819.6650 Da, 0.00 %\ncE: [10]\nScore: 1.0000"];
v2 [label="C6H13O3\n133.0863 Da, 72.59 %\ncE: [10]\nScore: -7.1438"];
v3 [label="C4H9O2\n89.0593 Da, 100.00 %\ncE: [10]\nScore: 14.4395"];
v4 [label="C6H13\n85.1005 Da, 29.18 %\ncE: [10]\nScore: 6.0633"];
v5 [label="C2H5O\n45.0334 Da, 41.80 %\ncE: [10]\nScore: 6.3635"];

v1 -> v2 [label="C51H74"];
v3 -> v5 [label="C2H4O"];

}
```


# docker
ref tutorial: https://www.youtube.com/watch?v=FlSup_eelYE

dockerfile: https://docs.docker.com/engine/reference/builder/

To start:

`docker build -t Sirius .`

`docker run -d --name Sirius-container -p 80:80 Sirius:latest`

`docker start Sirius-container`

To stop/remove container:

`docker stop Sirius-container`

`docker rm Sirius-container`

To start:

`docker build -t Passatuto .`

`docker run -d --name Passatuto-container -p 80:80 Passatuto:latest`  (debug mode)

`docker start Passatuto-container`

To stop/remove container:

`docker stop Passatuto-container`

`docker rm Passatuto-container`

# Use docker (not deploy yet not test yet)

` docker run -it --name Sirius-container -p 80:80 Sirius:latest; docker start Sirius-container`   (interactive mode)

` docker run -it --name Passatuto-container -p 80:80 Passatuto:latest; docker start Passatuto-container `






