# make reference annotations for hg19 genes and gene symbols
# requires BEDOPS http://bedops.readthedocs.io/en/latest/content/reference/file-management/conversion/gtf2bed.html

# no default action to take
none:

# make both sets of annotations
all: gencode ensembl

# ~~~~~ GENCODE ~~~~~ #
# generate the Gencode hg19 annotations .bed file
gencode: gencode.v19.annotation.genes.bed

gencode.v19.annotation.gtf.gz: 
	wget ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz

gencode.v19.annotation.genes.bed: gencode.v19.annotation.gtf.gz
	zcat gencode.v19.annotation.gtf.gz | grep -w gene | convert2bed --input=gtf - > gencode.v19.annotation.genes.bed


# ~~~~~ ENSEMBL ~~~~~ #
# generate the Ensembl hg19 annotations .bed file
ensembl: Homo_sapiens.GRCh37.82.noGLMT.chr.bed

Homo_sapiens.GRCh37.82.gtf.gz: 
	wget ftp://ftp.ensembl.org/pub/grch37/release-84/gtf/homo_sapiens/Homo_sapiens.GRCh37.82.gtf.gz

# Need to filter out the GL, MT entries
Homo_sapiens.GRCh37.82.noGLMT.gtf: Homo_sapiens.GRCh37.82.gtf.gz
	zcat Homo_sapiens.GRCh37.82.gtf.gz | grep -Ev "^#|^GL|^M" > Homo_sapiens.GRCh37.82.noGLMT.gtf

# need to add 'chr' to the start of each 1st entry
Homo_sapiens.GRCh37.82.noGLMT.chr.gtf: Homo_sapiens.GRCh37.82.noGLMT.gtf
	cat Homo_sapiens.GRCh37.82.noGLMT.gtf | sed 's/^/chr/' > Homo_sapiens.GRCh37.82.noGLMT.chr.gtf

# convert to .bed
Homo_sapiens.GRCh37.82.noGLMT.chr.bed: Homo_sapiens.GRCh37.82.noGLMT.chr.gtf
	gtf2bed < Homo_sapiens.GRCh37.82.noGLMT.chr.gtf > Homo_sapiens.GRCh37.82.noGLMT.chr.bed


.INTERMEDIATE: gencode.v19.annotation.gtf.gz \
	Homo_sapiens.GRCh37.82.gtf.gz \
	Homo_sapiens.GRCh37.82.noGLMT.gtf \
	Homo_sapiens.GRCh37.82.noGLMT.chr.gtf