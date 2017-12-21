# reference-annotations
Makefile for building .bed formatted reference annotation files for hg19 genes &amp; genomic regions

# Usage

First, clone this repository and change to its directory:

```bash
git clone https://github.com/stevekm/reference-annotations.git
cd reference-annotations
```

Generate the desired annotation files; either `gencode`, `ensembl`, or `all` for both Gencode and Ensembl.

```
make all

# or

make gencode

# or

make ensembl

```

# Output

The following files are created:

- `gencode.v19.annotation.genes.bed`: Gencode hg19 gene annotations & genomic regions

- `Homo_sapiens.GRCh37.82.noGLMT.chr.bed`: Ensembl hg19 gene annotations & genomic regions, with the following modifications:
  
  - removed file comments
  
  - removed entries with 'MT' listed for chromosome 
  
  - removed entries with 'GL....' listed for chromosome, e.g. 'GL000229.1'
  
  - added 'chr' to the start of all chromosome labels

# Notes

Intermediate files are removed by default. If you want to keep them, then comment out the `.INTERMEDIATE` section in the `Makefile`.

# Software

- GNU `make`

- [BEDOPS](http://bedops.readthedocs.io/en/latest/content/reference/file-management/conversion/gtf2bed.html) 
