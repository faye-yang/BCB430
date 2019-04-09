import os


#parse the passatuto file output file to a format that convert.py can use
def parse(input_path,output_path,directory):
    ms_counter = 0
    out=open(output_path,"a+")
    f = open(input_path)
    formulaList=[]
    #read from the transition files
    formula = " "

    for line in f:
        if line.startswith("Formula") :
            formula = line.split(": ")[1].split("\n")[0]
            if (formula not in formulaList) and ("1_" + formula + "_M+H+.txt") in os.listdir(directory):
                out.write(line)
            ms_counter=0
        if ("1_" + formula + "_M+H+.txt") in os.listdir(directory) and (formula not in formulaList):
            if line.startswith("Charge") \
                    or line.startswith( "RT") \
                    or line.startswith("Sample") \
                    or line.startswith("Elution")\
                    or line.startswith("Isotope"):
                ms_counter+=1
                out.write(line)

            elif line.startswith("MS2_Spectrum"):
                if ms_counter ==5:
                    out.write(line.split("/n")[0])
                    i = 0

                    with open(directory+"1_"+formula+"_M+H+.txt", 'r+') as f:
                        mzlist = []
                        sumInt = 0
                        peakIntensity = []
                        infos = f.readlines()
                        while i < len(infos):
                            info = infos[i]
                            if "PK$PEAK" in info:
                                i += 1
                                while "//" not in infos[i]:
                                    info = infos[i]
                                    Peak_info_list=info.split(" ")
                                    mz=float(Peak_info_list[2])
                                    mz=round(mz, 3)
                                    relativeInt=round(float(Peak_info_list[4].split("\n")[0]),3)
                                    sumInt=sumInt+relativeInt
                                    mzlist.append(mz)
                                    peakIntensity.append(relativeInt)
                                    i += 1
                                if sumInt !=0:
                                    peakIntensity[:] = [x / sumInt for x in peakIntensity]


                            elif "//" in infos[i]:
                                for IntInd in range(len(peakIntensity)):
                                    string = str(mzlist[IntInd]) + "\t" + str(peakIntensity[IntInd]) + "\n"
                                    out.write(string)
                                formulaList.append(formula)

                                i+=1

                            else:
                                i +=1
                    f.close()

    out.close()
    f.close()


if __name__ == "__main__":
 #inp = "./DDA_consensus_library_pos.txt"
 int="./DDA_library_pos.txt"

 # example data
 #Formula: C6H7N5O2
 #Charge: 1
 #RT: 33.8837333333333
 #Sample: 30/60
 #Elution: 30
 #Isotope: 2
 #MS2_Spectrum: 30
 counter1=0
 directory = "/Users/yufei/Desktop/2019winter/BCB430/Passatutto2/output_reroot/"
 parse(int, "/Users/yufei/Desktop/2019winter/BCB430/DDA_decoy_library.txt", directory)


         # find the files that do not have an output from passatuto2 reroot method
 # formularList=[]
 # counter=[]
 # for filename in os.listdir(directory):
 #    filename = os.path.splitext(filename)[0]
 #    formularList.append(filename)
 # f= open(int)
 # out=open("/Users/yufei/Desktop/2019winter/BCB430/DDA_library_pos.txt","a+")
 # for line in f:
 #     formula = ""
 #     if line.startswith("Formula"):
 #         formula = line.split(": ")[1].split("\n")[0]
 #         out.write(line)
 #     if formula not in formularList:
 #        if formula not in counter:
 #             counter.append(formula)
 #
 #        if not line.startswith("Formula"):
 #            out.write(line)
 #        else:
 #            pass
 # print(len(counter),len(os.listdir(directory)))





