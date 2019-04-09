#!/usr/bin/python
import csv
from pyteomics import mass
import random

csvheader=[
"PrecursorMz",
"ProductMz",
"Tr_recalibrated",
"transition_name",
"CE",
"LibraryIntensity",
"transition_group_id",
"decoy",
"PeptideSequence",
"ProteinName",
"CompoundName",
"SumFormula",
"PrecursorCharge",
"LabelTyp"
]

cnt = 1
cnt_trgr = 1
RT_MINDIST = 160

def process_stack(stack, topN=None):
    assert len(stack) > 7
    print(stack)
    global cnt, cnt_trgr
    header = stack[:7]
    fragments = stack[7:]
    nr_samples = stack[3].split(":")[1].split("/")[0]
    nr_isotopes = stack[5].split(":")[1]
    nr_spectra = stack[6].split(":")[1]
    sumformula = header[0].split(": ")[1]
    charge = int(header[1].split(": ")[1])
    rt = float(header[2].split(": ")[1])
    precursor_mz = abs(mass.calculate_mass(formula=sumformula, charge=charge))
    #
    res = []
    tmpres = []
    for f in fragments:
        mz, inten = f.split("\t")
        mz = float(mz)
        tmpres.append([
            precursor_mz,
            mz,
            rt,
            "%s_%s"  % (cnt, sumformula),
            -1,
            inten,
            "%s_%s"  % (cnt_trgr, sumformula), # transition_group_id
            1, # decoy
            "", # sum-formula
            "", # protein name
            sumformula,
            sumformula,
            charge,
            "light"]
        )

        cnt += 1

    cnt_trgr += 1

    # Sort by intensity

    tmpres.sort(key=lambda x: float(x[5]),reverse = True)

    if topN:
        tmpres = tmpres[:topN]
    res.extend(tmpres)
    return res



import sys


#inp = sys.argv[1]
#outp = sys.argv[2]
if __name__ == "__main__":
 inpDecoy = "/Users/yufei/Desktop/2019winter/BCB430/DDA_decoy_library_reroot.txt"
 outp = "/Users/yufei/Desktop/2019winter/BCB430/decoy_library_reroot.tsv"
 inp="./DDA_consensus_library_pos.tsv"

 flibrary=open(inp)
 f = open(inpDecoy)
 fout = open(outp, "w+")
 fomulaList=[]
 for line in flibrary:
    if line.startswith("Formula") :
        formula = line.split(": ")[1].split("\n")[0]
        if (formula not in fomulaList):
            fomulaList.appand(formula)


 out = csv.writer(fout, delimiter = '\t')
 out.writerow(csvheader)
 stack = []
 for line in f:
    if line.startswith("Formula"):
        print("line:",line)
        if len(stack) != 0:
            q = process_stack(stack, 6)
            for qq in q:
                out.writerow(qq)
            stack = []
    stack.append(line.strip())




