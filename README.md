# reference-annotations
Makefile for building .bed formatted reference annotation files for hg19 human genome genes &amp; genomic regions

# Usage

First, clone this repository and change to its directory:

```bash
git clone https://github.com/stevekm/reference-annotations.git
cd reference-annotations
```

Generate the desired annotation files from the available entries:

- `all`, `gencode-hg19`, `gencode-hg38`, `ensembl-hg19`, `ensembl-hg38`

```
make all

# or

make gencode-hg19

# or

make ensembl-hg19

# etc. ....
```

# Output

The following files are created:

- `gencode-hg19`: `gencode.v19.annotation.genes.bed`; Gencode hg19 gene annotations & genomic regions

- `gencode-hg38`: `gencode.v27.annotation.genes.bed`; Gencode hg38 gene annotations & genomic regions

- `ensembl-hg19`: `Homo_sapiens.GRCh37.82.chr.bed`; Ensembl hg19 gene annotations & genomic regions

- `ensembl-hg38`: `Homo_sapiens.GRCh38.91.chr.bed`; Ensembl hg38 gene annotations & genomic regions

# Notes

Intermediate files are removed by default. If you want to keep them, then comment out the `.INTERMEDIATE` section in the `Makefile`.

# Software

- GNU `make`

- [BEDOPS](http://bedops.readthedocs.io/en/latest/content/reference/file-management/conversion/gtf2bed.html) 

# Resources

- Gencode Releases: https://www.gencodegenes.org/releases/

- Ensembl Releases: https://useast.ensembl.org/info/data/ftp/index.html
