from snakemake.remote.S3 import RemoteProvider as S3RemoteProvider
S3 = S3RemoteProvider(
    access_key_id=config["key"],
    secret_access_key=config["secret"],
    host=config["host"],
    stay_on_remote=False
)
prefix = config["prefix"]
filename = config["filename"]

rule get_full_exp_list:
    input:
        S3.remote(prefix + 'processed/GSE134836_list.rds'),
        S3.remote(prefix + 'processed/GSE134838_list.rds'),
        S3.remote(prefix + 'processed/GSE134839_list.rds'),
        S3.remote(prefix + 'processed/GSE134841_list.rds'),
        S3.remote(prefix + 'processed/GSE149214_list.rds'),
        S3.remote(prefix + 'processed/GSE149215_list.rds'),
        S3.remote(prefix + 'processed/GSE160244_list.rds')
    output:
        S3.remote(prefix + 'scRNA_response.rds')
    resources:
        mem_mb = 12000
    shell:
        """
        Rscript scripts/get_full_exp_list.R \
        {prefix}processed \
        {prefix}
        """

rule process_GSE160244:
    input:
        S3.remote(prefix + 'download/GSE160244_RAW.tar')
    output:
        S3.remote(prefix + 'processed/GSE160244_list.rds')
    shell:
        """
        Rscript scripts/process_GSE160244.R \
        {prefix}download \
        {prefix}processed
        """

rule process_GSE149215:
    input:
        S3.remote(prefix + 'download/GSE149215_RAW.tar')
    output:
        S3.remote(prefix + 'processed/GSE149215_list.rds')
    shell:
        """
        Rscript scripts/process_GSE149215.R \
        {prefix}download \
        {prefix}processed
        """

rule process_GSE149214:
    input:
        S3.remote(prefix + 'download/GSE149214_RAW.tar'),
    output:
        S3.remote(prefix + 'processed/GSE149214_list.rds')
    shell:
        """
        Rscript scripts/process_GSE149214.R \
        {prefix}download \
        {prefix}processed
        """

rule process_GSE134841:
    input:
        S3.remote(prefix + 'download/GSE134841_RAW.tar')
    output:
        S3.remote(prefix + 'processed/GSE134841_list.rds')
    shell:
        """
        Rscript scripts/process_GSE134841.R \
        {prefix}download \
        {prefix}processed
        """

rule process_GSE134839:
    input:
        S3.remote(prefix + 'download/GSE134839_RAW.tar')
    output:
        S3.remote(prefix + 'processed/GSE134839_list.rds')
    shell:
        """
        Rscript scripts/process_GSE134839.R \
        {prefix}download \
        {prefix}processed
        """

rule process_GSE134836:
    input:
        S3.remote(prefix + 'download/GSE134836_RAW.tar')
    output:
        S3.remote(prefix + 'processed/GSE134836_list.rds')
    shell:
        """
        Rscript scripts/process_GSE134836.R \
        {prefix}download \
        {prefix}processed
        """

rule process_GSE134838:
    input:
        S3.remote(prefix + 'download/GSE134838_RAW.tar')
    output:
        S3.remote(prefix + 'processed/GSE134838_list.rds')
    shell:
        """
        Rscript scripts/process_GSE134838.R \
        {prefix}download \
        {prefix}processed
        """

rule download_data:
    output:
        S3.remote(prefix + 'download/GSE134836_RAW.tar'),
        S3.remote(prefix + 'download/GSE134838_RAW.tar'),
        S3.remote(prefix + 'download/GSE134839_RAW.tar'),
        S3.remote(prefix + 'download/GSE134841_RAW.tar'),
        S3.remote(prefix + 'download/GSE149214_RAW.tar'),
        S3.remote(prefix + 'download/GSE149215_RAW.tar'),
        S3.remote(prefix + 'download/GSE160244_RAW.tar')
    shell:
        """
        Rscript scripts/download.R \
        {prefix}
        """
