rule harmonize_sumstats:
    input:
        sumstats=get_sumstats,
    output:
        ws_path("outputs/{seqid}/{seqid}.gwaslab.tsv.gz"),
    conda:
        "../envs/gwaspipe.yaml"
    params:
        format=config.get("params").get("harmonize_sumstats").get("input_format"),
        config_file=config.get("params").get("harmonize_sumstats").get("config_file"),
        output_path=config.get("workspace_path"),
    shell:
        "gwaspipe "
        "-f {params.format} "
        "-c {params.config_file} "
        "-i {input.sumstats} "
        "-o {params.output_path}"


rule bgzip_tabix:
    input:
        ws_path("outputs/{seqid}/{seqid}.gwaslab.tsv.gz"),
    output:
        ws_path("outputs/{seqid}/{seqid}.gwaslab.tsv.gz.tbi"),
    conda:
        "../envs/bgzip_tabix.yaml"
    shell:
        "workflow/scripts/bgzip_tabix.sh {input} {threads}"
