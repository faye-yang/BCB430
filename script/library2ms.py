import csv
import os


#PrecursorMz	ProductMz	Tr_recalibrated	transition_name	CE	LibraryIntensity	transition_group_id	decoy
## PeptideSequence	ProteinName	CompoundName	SumFormula	PrecursorCharge	LabelTyp


#formater for product mz and normalized intensity for fragmentation tree
def parseLibMsSirius(list):
    line1 = list[1] + " "+list[5] + "\n"
    f = open("/Users/yufei/Desktop/2019winter/BCB430/Passatutto2/fragmentationTree/" + list[11] + ".txt", "a+")
    f.write(line1)
    f.close()



# formater for ms file for passatutto
def parseLibMS(list):
    line1= ">compound " +list[10] + "\n"
    line2="#instrument LTQ Orbitrap XL Thermo Scientific" + "\n"
    line3=">formula " + list[11]+ "\n"
    line4 = "# inchi NA" + "\n"
    line5 = "# smiles NA" + "\n"
    line6 = ">charge 1"+ "\n"
    line7=">ionization[M + H] +" +"\n"
    line8=">parentmass " + list[0] +"\n"
    line9=">collision 15\n56.0494 120182.0\n126.0101 457475.0\n181.0526 42440.2" \
          "\n187.098 68559.0\n196.0642 97072.6\n206.0484 43283.8\n223.0742 35723206.3"
    line_list=[]
    line_list.append(line1)
    line_list.append(line2)
    line_list.append(line3)
    line_list.append(line4)
    line_list.append(line5)
    line_list.append(line6)
    line_list.append(line7)
    line_list.append(line8)
    line_list.append(line9)
    f = open("/Users/yufei/Desktop/2019winter/BCB430/Passatutto2/data2/" + list[11] + ".ms", "w+")
    for line in line_list:
        f.write(line)
        #print(line)

    f.close()

def formatSirius(path):
    counter=0
    molecularFor={}
    filename="/Users/yufei/Desktop/2019winter/BCB430/Passatutto2/TreeDir/"+os.path.basename(path)
    f=open(filename,"w+")
    f.write("strict digraph {\n")
    v_count = 1
    with open(path) as fd:
        for line in fd:
            if(counter>=4):
                #node info
                string_write=""

                if("<BR />" in line):
                    tmp=line.split("<BR />")
                    mass=tmp[2]
                    score=tmp[3].split("</FONT>>")[0]
                    vector="v"+str(v_count)
                    formular=tmp[0].split(" [")[0]
                    formular=formular.replace("\t","")
                    print("formular",formular)
                    # write to a file
                    string_write = "	"+vector+" [label=\"{}\\n{}\\ncE: [10]\\nScore: {}\"];\n".format(formular,mass,score)
                    molecularFor[formular]=vector
                    print("updirected molecular info:",string_write)
                    f.write(string_write)
                    v_count += 1
                #directed path
                elif(" -> " in line):
                    #map formular to node id and give molecule
                    temp=line.split(" -> ")
                    v1=molecularFor.get(temp[0].replace("\t",""))
                    print("temp:",temp[1].split(" "))
                    v2=molecularFor.get(temp[1].split(" ")[0])
                    labelString=temp[1].split(" ")[1]
                    labelString=labelString.split("[label=<")[1]

                    moleculeName=""
                    if("</SUB>" in labelString):

                        moleculeList=labelString.split("</SUB>")

                        for i in range(len(moleculeList)-1):
                            if("<SUB>" in moleculeList[i]):
                                atom=moleculeList[i].split("<SUB>")[0]
                                num=moleculeList[i].split("<SUB>")[1]
                                moleculeName=moleculeName+atom+num
                        n=len(moleculeList)-1
                        lastatome=moleculeList[n].split(">];")[0]
                        if(lastatome!=""):
                            print("lastatome",lastatome)
                            moleculeName=moleculeName+lastatome

                    else:
                        moleculeName=labelString.split(">")[0]

                    #C3H6O7P -> C3HO2P [label=<H<SUB>5</SUB>O<SUB>5</SUB>>];
                    #v41 -> v32 [label="C6H15N"];
                    print("moleculeName:",moleculeName)

                    string_write="	{} -> {} [label=\"{}\"];\n".format(v1,v2,moleculeName)
                    print("directed info:",string_write)
                    f.write(string_write)
                else:
                    f.write("\n")

            counter += 1
    f.write("}")








if __name__ == "__main__":

    # list=[]
    # with open("DDA_consensus_library_pos.tsv") as fd:
    #     rd = csv.reader(fd, delimiter="\t", quotechar='"')
    #     for i in rd:
    #         list.append(i)
    #     print(list[1])
    # counter = 1

    # formater for ms file for passatutto
    #while counter < len(list):
    #    parseLibMs(list[counter])
    #
    #     counter+=1

    ##formater for product mz and normalized intensity for fragmentation tree
    # while counter < len(list):
    #     parseLibMsSirius(list[counter])
    #     counter += 1


    #parse dot file from sirius for passatuto2
    #set directory must include the last /
    directory="/Users/yufei/Desktop/2019winter/BCB430/Passatutto2/tree_dot/"

    for filename in os.listdir(directory):
         formatSirius(directory+filename)

    #formatSirius(directory +"1_C4H4N2O2_M+H+.dot")

