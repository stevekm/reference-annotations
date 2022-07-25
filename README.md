# reference-annotations
Makefile for building .bed formatted reference annotation files for hg19 human genome genes &amp; genomic regions

# Usage

First, clone this repository and change to its directory:

```bash
git clone https://github.com/stevekm/reference-annotations.git
cd reference-annotations
```

(if you do not have BEDOPS installed and in your PATH you can also run the `make bin` recipe to download it in the current dir)

Generate the desired annotation files from the available entries:

- `all`, `gencode-hg19`, `gencode-hg38`, `gencode-hg38v41`, `ensembl-hg19`, `ensembl-hg38`, `ensembl-mm10`

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

- `gencode-hg19`: `gencode.v19.annotation.genes.bed`; Gencode hg19 human gene annotations & genomic regions

- `gencode-hg38`: `gencode.v27.annotation.genes.bed`; Gencode hg38 human gene annotations & genomic regions

- `gencode-hg38v41`: `gencode.v41.annotation.genes.bed`; Gencode hg38 human gene annotations version 41 & genomic regions

- `ensembl-hg19`: `Homo_sapiens.GRCh37.82.chr.bed`; Ensembl hg19 human gene annotations & genomic regions

- `ensembl-hg38`: `Homo_sapiens.GRCh38.91.chr.bed`; Ensembl hg38 human gene annotations & genomic regions

- `ensembl-mm10`: `Mus_musculus.GRCm38.91.chr.bed`; Ensembl mm10 mouse gene annotations & genomic regions

# Annotation Example

In addition to general reference usage, these files can also be used to annotate other genomic region files with a [bedmap](http://bedops.readthedocs.io/en/latest/content/reference/statistics/bedmap.html) command like this:

```bash
bedmap --echo --echo-map-id --delim '\t' example-NGS-data/ChIP-Seq/bed/Sample1-D-H3K27AC/peaks.bed reference-annotations/gencode.v19.annotation.genes.id4.bed
```

# Notes

Intermediate files are removed by default. If you want to keep them, then comment out the `.INTERMEDIATE` section in the `Makefile`.

# Software

- GNU `make`

- `bash` shell

- [BEDOPS](http://bedops.readthedocs.io/en/latest/content/reference/file-management/conversion/gtf2bed.html)

# Resources

- Gencode Releases: https://www.gencodegenes.org/releases/

- Ensembl Releases: https://useast.ensembl.org/info/data/ftp/index.html
