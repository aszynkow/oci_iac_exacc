# oci_iac_exacc

Terraform scaffold for OCI Exadata Cloud@Customer infrastructure automation.

## Resource Manager Stack

The initial OCI Resource Manager stack package is available here:

[downloads/release/0.0.1/oci_iac_exacc-rm-stack-0.0.1.zip](downloads/release/0.0.1/oci_iac_exacc-rm-stack-0.0.1.zip)

The release folders are versioned so future Resource Manager stack packages can be published under new paths such as `downloads/release/0.0.2`.

## Build The Stack Zip

`rm_zip.sh` is a local helper script and is intentionally ignored by git. It builds a Resource Manager zip containing only Terraform files and `schema.yaml`.

```sh
./rm_zip.sh
```

To build another version:

```sh
./rm_zip.sh 0.0.2
```
