#!/bin/bash

plink2 \
	--export bgen-1.2 bits=8 \
	--pgen Rum_recoded_repos.bed \
	--pvar Rum_recoded_repos.bim \
	-psam Rum_recoded_repos.fam \
	--maj-ref 'force' \
	--allow-extra-chr \
	--out Rum_recoded_repos \
	--autosome-num 33
