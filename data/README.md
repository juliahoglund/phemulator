# Test data

Due to space constraints, test data cannot be included in this repo.
Throughout the development phase, we have used data from:

Hewett, A.M., Stoffel, M.A., Peters, L. et al. Selection, recombination and population history effects on runs of homozygosity (ROH) in wild red deer (Cervus elaphus). Heredity 130, 242–250 (2023). [https://doi.org/10.1038/s41437-023-00602-z](https://doi.org/10.1038/s41437-023-00602-z)

1. Download data from Dryad repository: [https://datadryad.org/stash/dataset/doi:10.5061/dryad.mpg4f4r49](https://datadryad.org/stash/dataset/doi:10.5061/dryad.mpg4f4r49)
2. Convert PLINK format data to bgen format using our `convert.sh` script. NOTE: You have to have [PLINK2](https://www.cog-genomics.org/plink/2.0/) installed on your machine. We used `Rum_recorded*` files.
3. Some made up regions are in `cds_test.bed`.
4. You are now ready to use Phemulator.
