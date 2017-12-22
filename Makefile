# make reference annotations for hg19 genes and gene symbols
# requires BEDOPS http://bedops.readthedocs.io/en/latest/content/reference/file-management/conversion/gtf2bed.html

# no default action to take
none:

# make all sets of annotations
all: gencode-hg19 ensembl-hg19 gencode-hg38 ensembl-hg38


# ~~~~~ GENCODE hg19 ~~~~~ #
# generate the Gencode hg19 annotations .bed file
gencode-hg19: gencode.v19.annotation.genes.bed

gencode.v19.annotation.gtf.gz: 
	wget ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz

gencode.v19.annotation.genes.bed: gencode.v19.annotation.gtf.gz
	zcat gencode.v19.annotation.gtf.gz | grep -w gene | convert2bed --input=gtf - > gencode.v19.annotation.genes.bed




# ~~~~~ GENCODE hg38 ~~~~~ #
# generate the Gencode hg38 annotations .bed file

gencode-hg38: gencode.v27.annotation.genes.bed

gencode.v27.annotation.gtf.gz: 
	wget ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_27/gencode.v27.annotation.gtf.gz

gencode.v27.annotation.genes.bed: gencode.v27.annotation.gtf.gz
	zcat gencode.v27.annotation.gtf.gz | grep -w gene | convert2bed --input=gtf - > gencode.v27.annotation.genes.bed



# ~~~~~ ENSEMBL hg19 ~~~~~ #
# generate the Ensembl hg19 annotations .bed file
ensembl-hg19: Homo_sapiens.GRCh37.82.chr.bed

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
ensembl-hg38: Homo_sapiens.GRCh38.91.chr.bed

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


# ~~~~~ CLEAN UP ~~~~~ #
.INTERMEDIATE: gencode.v19.annotation.gtf.gz \
	Homo_sapiens.GRCh37.82.gtf.gz \
	Homo_sapiens.GRCh37.82.noGLMT.gtf \
	Homo_sapiens.GRCh37.82.noGLMT.chr.bed \
	Homo_sapiens.GRCh37.82.noGLMT.chr.gtf \
	gencode.v27.annotation.gtf.gz \
	Homo_sapiens.GRCh38.91.chr.gtf \
	Homo_sapiens.GRCh38.91.chr.gtf.gz \
	Homo_sapiens.GRCh37.82.chr.gtf \
	Homo_sapiens.GRCh37.82.chr.gtf.gz
	
	