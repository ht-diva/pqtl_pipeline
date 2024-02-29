
rule convert_sumstats_to_vcf:
    input:
        ws_path("results/pickle/{seqid}.pkl"),
    output:
        ws_path("results/vcf/{seqid}/{seqid}.vcf.gz"),
        ws_path("results/vcf/{seqid}/{seqid}.vcf.gz.csi"),
    conda:
        "../scripts/gwaspipe/environment.yml"
    params:
        format=config.get("params").get("convert_sumstats_to_vcf").get("input_format"),
        config_file=config.get("params")
        .get("convert_sumstats_to_vcf")
        .get("config_file"),
    resources:
        runtime=lambda wc, attempt: attempt * 100,
    shell:
        "python workflow/scripts/gwaspipe/src/gwaspipe.py "
        "-f {params.format} "
        "-c {params.config_file} "
        "-i {input}"
