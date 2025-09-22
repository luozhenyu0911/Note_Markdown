# 用你擅长的文本编辑器
vim Snakefile
# 编辑如下内容


rule bwa_map:
    input:
        "data/genome.fa",
        "data/samples/{sample}.fastq"
    output:
        "mapped_reads/{sample}.bam"
    shell:
        """
        bwa mem {input} | samtools view -Sb - > {output}
        """

rule samtools_sort:
    input:
        "mapped_reads/{sample}.bam"
    output:
        "sorted_reads/{sample}.bam"
    shell:
        "samtools sort -O bam {input} -o {output}"

rule samtools_index:
    input:
        "sorted_reads/{sample}.bam"
    output:
        "sorted_reads/{sample}.bam.bai"
    shell:
        "samtools index {input}"

# snakemake --dag sorted_reads/{A,B}.bam.bai | dot -Tsvg > dag.svg

snakemake --rulegraph -s /BIGDATA2/gzfezx_shhli_2/USER/luozhenyu/script/blood_viromes/run.all.smk | dot -Tpdf > virome2.pdf
/BIGDATA2/gzfezx_shhli_2/miniconda3/envs/cnvnator/bin/snakemake --rulegraph --configfile ./config.yaml \
-s /BIGDATA2/gzfezx_shhli_2/USER/luozhenyu/script/pb_sv_detection/smk/run.all.smk | dot -Tpdf > pb_sv_detection.pdf


snakemake --dag -s $smk | dot -Tpdf > WGS_SV_2.pdf


#############################  

snakemake -nps run.all.smk --allowed-rules  metaSV_merge_vcf_no_pindel                                                                           

########################

SAMPLES=["A","B"]
rule bcftools_call:
    input:
        fa="data/genome.fa",
        bam=expand("sorted_reads/{sample}.bam", sample=SAMPLES),
        bai=expand("sorted_reads/{sample}.bam.bai", sample=SAMPLES)
    output:
        "calls/all.vcf"
    shell:
        "samtools mpileup -g -f {input.fa} {input.bam} | "
        "bcftools call -mv - > {output}"

# snakemake -p calls/all.vcf
# snakemake --dag scalls/all.vcf | dot -Tsvg > dag2.svg
rule report:
    input:
        "calls/all.vcf"
    output:
        "report.html"
    run:
        from snakemake.utils import report
        with open(input[0]) as vcf:
            n_calls = sum(1 for l in vcf if not l.startswith("#"))

        report("""
        An example variant calling workflow
        ===================================

        Reads were mapped to the Yeast
        reference genome and variants were called jointly with
        SAMtools/BCFtools.

        This resulted in {n_calls} variants (see Table T1_).
        """, output[0], T1=input[0])

# 对流程进一步修饰

rule bwa_map:
    input:
        "data/genome.fa",
        "data/samples/{sample}.fastq"
    output:
        "mapped_reads/{sample}.bam"
    threads:8
    shell:
        "bwa mem -t {threads} {input} | samtools view -Sb - > {output}"

snakemake --cores 10

# config.yaml
samples:
    A: data/samples/A.fastq
    B: data/samples/B.fastq
    
configfile: "config.yaml"
...
rule bcftools_call:
    input:
        fa="data/genome.fa",
        bam=expand("sorted_reads/{sample}.bam", sample=config["samples"]),
        bai=expand("sorted_reads/{sample}.bam.bai", sample=config["smaples])
    output:
        "calls/all.vcf"
    shell:
        "samtools mpileup -g -f {input.fa} {input.bam} | "
        "bcftools call -mv - > {output}"

rule bwa_map:
    input:
        "data/genome.fa",
        config['samples']["{sample}"]
    output:
        "mapped_reads/{sample}.bam"
    threads:8
    shell:
        "bwa mem -t {threads} {input} | samtools view -Sb - > {output}"

























