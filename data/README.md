# Test data

Due to space constraints, test data cannot be included in this repo.
Throughout the development phase, we have used data from:

Hewett, A.M., Stoffel, M.A., Peters, L. et al. Selection, recombination and population history effects on runs of homozygosity (ROH) in wild red deer (Cervus elaphus). Heredity 130, 242–250 (2023). [https://doi.org/10.1038/s41437-023-00602-z](https://doi.org/10.1038/s41437-023-00602-z)

1. Download data from Dryad repository: [https://datadryad.org/stash/dataset/doi:10.5061/dryad.mpg4f4r49](https://datadryad.org/stash/dataset/doi:10.5061/dryad.mpg4f4r49)
2. Convert PLINK format data to bgen format using our `convert.sh` script. NOTE: You have to have [PLINK2](https://www.cog-genomics.org/plink/2.0/) installed on your machine. We used `Rum_recorded*` files.
3. You also need to index the bgen file using `bgenix` tool (available [here](https://www.well.ox.ac.uk/~gav/resources/)) `bgenix -g Rum_recoded_repos.bgen -index` 
4. Some made up regions are provided in `cds_test.bed`.
5. You are now ready to use Phemulator:
   ```
   python phemulator.py --name my_simulation --bed_regions_path my_regions.bed --bgen_file_path my_data.bgen
   ```
   
   And you should see something like this chunk below. Ignore the error -- it comes from the fact that we have sex chromosomes included. You can
   redirect `stderr` to `/dev/null` if you do not like it: `python phemulator.py --name my_simulation --bed_regions_path my_regions.bed --bgen_file_path my_data.bgen
 2>/dev/null`  
   
   ```
   ERROR. Chromosome 33, position 79254683: data/Rum_recoded_repos.bgen: only accepting ploidy of 2. Skipping over...
   Validating 3 regions on chromosome 1 from data/cds_test.bed...  done in 7.44s.
   Found 1 region(s) matching simulation criteria.
   Drawing 2 region(s) for simulation (w. replacement)  done in 0.0s.
   Performing simulation 1 of 2...
	     - processing region NM_TEST2
		   - scanning variants in the region
		   - selecting variants
		   - simulating phenotype
		   - simulated phenotype mean = 0.41, std. dev = 0.73
		   - done in 0.04s.
   Performing simulation 2 of 2...
	     - processing region NM_TEST2
		   - scanning variants in the region
		   - selecting variants
		   - simulating phenotype
		   - simulated phenotype mean = 0.28, std. dev = 0.65
		   - done in 0.03s.
   ```

   Two files have been generated in `./out`:
   * simulation_Rum_recoded_repos.bgen_cds_test.bed_10-20-2023.json
   * phenotypes_simulation_Rum_recoded_repos.bgen_cds_test.bed_10-20-2023.csv

   The `simulation...` file contains the following info:

```
  {
    "chromosome": "1",
    "start": 27590000,
    "stop": 28590000,
    "region_name": "NM_TEST2",
    "num_rare": 2,
    "num_common": 13,
    "is_valid": "yes"
}
variant_name,chr,pos,type,eff,maf
cela1_red_15_13697173,1,27968376,rare,2.2034376251895638,0.029885057471264367
cela1_red_15_13803325,1,27976402,rare,2.377858260463359,0.02315270935960591
cela1_red_15_14287548,1,28498472,common,0.2934033455531529,0.41986863711001643
```

First part within `{` and `}` is region description in json format. Here, `NM_TEST2` fullfilled your simulation criteria and
has been used (note, the same region may be used for simulations several times). It contained 2 rare (based on provided threshold) variants and
13 common variants and thus was valid for simulation (default requirement is 1 common variant and 2 rare ones).

The second part shows info about the actual variants in that region that have been used for simulation. `eff` is the effect size.

---

The `phenotypes...` file is a csv data table with first column being individual ids and the following columns `y1` ... `y_n` being the simulated phenotypes.  
