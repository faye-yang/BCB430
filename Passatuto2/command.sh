java -cp "lib/passatutto.jar:lib/json-1.0.jar:lib/commons-math3-3.4.1.jar:lib/trove4j-3.0.3.jar" DecoyDatabaseConstruction -target ./data2 -out /outputRandom -method RandomPeaks -ppm 10 -ae 2

java -cp lib/passatutto.jar:lib/json-1.0.jar:lib/commons-math3-3.4.1.jar:lib/trove4j-3.0.3.jar DecoyDatabaseConstruction -target ./tree_dot -out ./output_reroot -method Reroot -ppm 10 -ae 2