*Data file for passatuto (docker)
- Library file: DDA_consensus_library_pos.tsv
- .Dot files from SIRUS:Passatuto2/tree_dot
- parsed .Dot files from .Dot file for Passatuto: Passatuto2/TreeDir
- source data from Passatuto2: Passatuto2/Data
- parsed .ms file for RandomPeaks and conditionalPeak method: Passatuto2/data2
- partial data from reroot method from passatuto: Passatuto2/output_reroot


*tools using (not included in the github but in gitter):
- SIRIUS:a tool that construct a fragmentation tree
- Passatuto2: a tool that construct decoy library using 4 methods,RandomPeaks, conditionalPeak, reroot, and Empirical-Bayes-
Approach(this appoarch can only support for the tool source data using method and database: MassBank,CosineDistance).

e.g. java -cp "lib/passatutto.jar:lib/json-1.0.jar:lib/commons-math3-3.4.1.jar:lib/trove4j-3.0.3.jar" DecoyDatabaseConstruction -target /data2 -out /outputRandom -method RandomPeaks -ppm 10 -ae 2


* script directoy:
- convert.py: a script from Prof. Hannes Rost that convert decoy library.
- control.sh:example command and output from Prof. Hannes Rost for running the OpenSwath and pyprophet

- library2ms.py:
* goal:parse mass spectrometry library file (e.g.DDA_consensus_library_pos.tsv) to ms file for sirius and passatuto for RandomPeaks and conditionalPeak method and parse file from .dot to older version of SIRIUS .dot for reroot method.

function:
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

e.g.
'''
strict digraph {
	v1 [label="C57H87O3\n819.6650 Da, 0.00 %\ncE: [10]\nScore: 1.0000"];
	v2 [label="C6H13O3\n133.0863 Da, 72.59 %\ncE: [10]\nScore: -7.1438"];
	v3 [label="C4H9O2\n89.0593 Da, 100.00 %\ncE: [10]\nScore: 14.4395"];
	v4 [label="C6H13\n85.1005 Da, 29.18 %\ncE: [10]\nScore: 6.0633"];
	v5 [label="C2H5O\n45.0334 Da, 41.80 %\ncE: [10]\nScore: 6.3635"];

	v1 -> v2 [label="C51H74"];
	v3 -> v5 [label="C2H4O"];

}
'''




