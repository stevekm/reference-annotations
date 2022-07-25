# make reference annotations for hg19 genes and gene symbols
# requires BEDOPS http://bedops.readthedocs.io/en/latest/content/reference/file-management/conversion/gtf2bed.html
SHELL:=/bin/bash
PATH:=$(CURDIR)/bin:$(PATH)

# no default action to take
none:

# download for the Bedops programs needed
bin:
	wget https://github.com/bedops/bedops/releases/download/v2.4.41/bedops_linux_x86_64-v2.4.41.tar.bz2 && \
	tar xjvf bedops_linux_x86_64-v2.4.41.tar.bz2

# make all sets of annotations
all: gencode-hg19 ensembl-hg19 gencode-hg38 ensembl-hg38 ensembl-mm10

gencode-hg19: gencode.v19.annotation.genes.id4.bed

gencode-hg38: gencode.v27.annotation.genes.bed

gencode-hg38v41: gencode.v41.annotation.genes.bed

ensembl-hg19: Homo_sapiens.GRCh37.82.chr.bed

ensembl-hg38: Homo_sapiens.GRCh38.91.chr.bed

ensembl-mm10: Mus_musculus.GRCm38.91.chr.bed




# ~~~~~ GENCODE hg19 ~~~~~ #
# generate the Gencode hg19 annotations .bed file
gencode.v19.annotation.gtf.gz:
	wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz

gencode.v19.annotation.genes.bed: gencode.v19.annotation.gtf.gz
	zcat gencode.v19.annotation.gtf.gz | grep -w gene | convert2bed --input=gtf - > gencode.v19.annotation.genes.bed

gencode.v19.annotation.genes.id4.bed: gencode.v19.annotation.genes.bed
	paste <(cut -f1-3 gencode.v19.annotation.genes.bed) <(grep -o 'gene_name ".*"' gencode.v19.annotation.genes.bed | sed -e 's|gene_name ||g' | cut -d ';' -f1 | tr -d '"') <(cut -f4- gencode.v19.annotation.genes.bed) > gencode.v19.annotation.genes.id4.bed

# ~~~~~ GENCODE hg38 ~~~~~ #
# generate the Gencode hg38 annotations .bed file
gencode.v27.annotation.gtf.gz:
	wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_27/gencode.v27.annotation.gtf.gz

gencode.v27.annotation.genes.bed: gencode.v27.annotation.gtf.gz
	zcat gencode.v27.annotation.gtf.gz | grep -w gene | awk '{ if ($$0 ~ "transcript_id") print $$0; else print $$0" transcript_id \"\";"; }' | convert2bed --input=gtf - > gencode.v27.annotation.genes.bed

gencode.v41.annotation.gtf.gz:
	wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_41/gencode.v41.annotation.gtf.gz

gencode.v41.annotation.genes.bed: gencode.v41.annotation.gtf.gz
	zcat gencode.v41.annotation.gtf.gz | grep -w gene |	awk '{ if ($$0 ~ "transcript_id") print $$0; else print $$0" transcript_id \"\";"; }' | convert2bed --input=gtf - > gencode.v41.annotation.genes.bed


# ~~~~~ ENSEMBL hg19 ~~~~~ #
# generate the Ensembl hg19 annotations .bed file
Homo_sapiens.GRCh37.82.chr.gtf.gz:
	wget ftp://ftp.ensembl.org/pub/grch37/release-84/gtf/homo_sapiens/Homo_sapiens.GRCh37.82.chr.gtf.gz

# remove comment lines
# extract only 'gene' entries
# add 'chr' to first entry, change 'chrMT' to 'chrM'
Homo_sapiens.GRCh37.82.chr.gtf: Homo_sapiens.GRCh37.82.chr.gtf.gz
	zcat Homo_sapiens.GRCh37.82.chr.gtf.gz | grep -Ev '^#' | grep -w 'gene' | sed -e 's/^/chr/' -e 's/^chrMT/chrM/' > Homo_sapiens.GRCh37.82.chr.gtf

# convert to .bed
Homo_sapiens.GRCh37.82.chr.bed: Homo_sapiens.GRCh37.82.chr.gtf
	gtf2bed < Homo_sapiens.GRCh37.82.chr.gtf > Homo_sapiens.GRCh37.82.chr.bed



# ~~~~~ ENSEMBL hg38 ~~~~~ #
# generate the Ensembl hg19 annotations .bed file
Homo_sapiens.GRCh38.91.chr.gtf.gz:
	wget ftp://ftp.ensembl.org/pub/release-91/gtf/homo_sapiens/Homo_sapiens.GRCh38.91.chr.gtf.gz

# remove comment lines
# extract only 'gene' entries
# add 'chr' to first entry, change 'chrMT' to 'chrM'
Homo_sapiens.GRCh38.91.chr.gtf: Homo_sapiens.GRCh38.91.chr.gtf.gz
	zcat Homo_sapiens.GRCh38.91.chr.gtf.gz | grep -Ev '^#' | grep -w 'gene' | sed -e 's/^/chr/' -e 's/^chrMT/chrM/' > Homo_sapiens.GRCh38.91.chr.gtf

# convert to .bed
Homo_sapiens.GRCh38.91.chr.bed: Homo_sapiens.GRCh38.91.chr.gtf
	gtf2bed < Homo_sapiens.GRCh38.91.chr.gtf > Homo_sapiens.GRCh38.91.chr.bed




# ~~~~~ ENSEMBL mm10 ~~~~~ #
# generate the Ensembl hg19 annotations .bed file
Mus_musculus.GRCm38.91.chr.gtf.gz:
	wget ftp://ftp.ensembl.org/pub/release-91/gtf/mus_musculus/Mus_musculus.GRCm38.91.chr.gtf.gz

# remove comment lines
# extract only 'gene' entries
# add 'chr' to first entry, change 'chrMT' to 'chrM'
Mus_musculus.GRCm38.91.chr.gtf: Mus_musculus.GRCm38.91.chr.gtf.gz
	zcat Mus_musculus.GRCm38.91.chr.gtf.gz | grep -Ev '^#' | grep -w 'gene' | sed -e 's/^/chr/' -e 's/^chrMT/chrM/' > Mus_musculus.GRCm38.91.chr.gtf

# convert to .bed
Mus_musculus.GRCm38.91.chr.bed: Mus_musculus.GRCm38.91.chr.gtf
	gtf2bed < Mus_musculus.GRCm38.91.chr.gtf > Mus_musculus.GRCm38.91.chr.bed




# ~~~~~ CLEAN UP ~~~~~ #
.INTERMEDIATE: gencode.v19.annotation.gtf.gz \
	Homo_sapiens.GRCh37.82.gtf.gz \
	Homo_sapiens.GRCh37.82.noGLMT.gtf \
	Homo_sapiens.GRCh37.82.noGLMT.chr.bed \
	Homo_sapiens.GRCh37.82.noGLMT.chr.gtf \
	gencode.v27.annotation.gtf.gz \
	gencode.v41.annotation.gtf.gz \
	Homo_sapiens.GRCh38.91.chr.gtf \
	Homo_sapiens.GRCh38.91.chr.gtf.gz \
	Homo_sapiens.GRCh37.82.chr.gtf \
	Homo_sapiens.GRCh37.82.chr.gtf.gz \
	Mus_musculus.GRCm38.91.chr.gtf.gz \
	Mus_musculus.GRCm38.91.chr.gtf
