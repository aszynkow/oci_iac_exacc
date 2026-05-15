# OCI IaC ExaCC

Terraform scaffold and **OCI Resource Manager (ORM) stack** for provisioning an
Oracle Database **VM cluster on Exadata Cloud@Customer (ExaCC)** in an existing
ExaCC infrastructure.

The Terraform source lives under [`terraform/`](terraform/). The packaged ORM
stack zip used by the deploy button lives under [`downloads/release/`](downloads/release/).

---

## Table of contents

- [What gets deployed](#what-gets-deployed)
- [Prerequisites](#prerequisites)
- [Required IAM permissions](#required-iam-permissions)
- [Deploy the Resource Manager stack](#deploy-the-resource-manager-stack)
- [Stack inputs](#stack-inputs)
- [Stack outputs](#stack-outputs)
- [Repository layout](#repository-layout)

---

## What gets deployed

Running the stack creates **one ExaCC VM cluster** (`oci_database_vm_cluster`)
on an existing ExaCC infrastructure, using two existing DB servers and an
existing VM cluster network.

The stack creates:

- **One ExaCC VM cluster** with:
  - Configurable CPU cores, memory, data storage, and DB node storage.
  - Configurable Grid Infrastructure version (default `19.0.0.0`).
  - Configurable license model (`BRING_YOUR_OWN_LICENSE` or `LICENSE_INCLUDED`).
  - Optional **local backup** and **sparse disk group**.
  - SSH public keys for cluster access.
  - Defined tags and freeform tags (the stack auto-adds
    `managed_by = "terraform"` and `stack = "oci_iac_exacc"` freeform tags).

The stack **discovers / reuses** (does not create):

- The **ExaCC infrastructure** in `exacs_compartment_id`. You can pin it with
  `exadata_infrastructure_id`; otherwise the first infrastructure in the
  compartment is used.
- The **VM cluster network** under that infrastructure. You can pin it with
  `vm_cluster_network_id`; otherwise the first network for the resolved
  infrastructure is used.
- The first **two DB servers** under the resolved infrastructure
  (`db_servers[0]` and `db_servers[1]`).
- The **availability domain** (uses AD-1 of the tenancy).

> The stack does **not** create the ExaCC infrastructure, the VM cluster
> network, or the underlying DB servers. Those must already exist.

---

## Prerequisites

Before deploying:

- An **OCI tenancy** with **ExaCC infrastructure already provisioned** and at
  least **two available DB servers** under it.
- An **ExaCC VM cluster network** already provisioned and in `REQUIRES_VALIDATION`
  or `VALIDATED` state.
- A **target compartment** for the new VM cluster, plus the compartment that
  holds the existing ExaCC infrastructure (these may be the same compartment).
- One or more **SSH public keys** for cluster access.
- The IAM permissions listed below.

---

## Required IAM permissions

The user (or group) running the Resource Manager apply needs the following
permissions. Adjust scopes to your tenancy structure as needed.

### Manage the ORM stack itself

```text
Allow group <orm-users> to manage orm-stacks in compartment <deploy-compartment>
Allow group <orm-users> to manage orm-jobs   in compartment <deploy-compartment>
Allow group <orm-users> to read   orm-config in tenancy
```

### Create the ExaCC VM cluster (deployment compartment)

```text
Allow group <orm-users> to manage vm-clusters       in compartment <deploy-compartment>
Allow group <orm-users> to read   vm-cluster-networks in compartment <deploy-compartment>
```

### Discover the existing ExaCC infrastructure (ExaCC compartment)

```text
Allow group <orm-users> to read exadata-infrastructures in compartment <exacc-compartment>
Allow group <orm-users> to read vm-cluster-networks     in compartment <exacc-compartment>
Allow group <orm-users> to read db-servers              in compartment <exacc-compartment>
```

### Identity / metadata lookups

```text
Allow group <orm-users> to inspect compartments         in tenancy
Allow group <orm-users> to read    availability-domains in tenancy
```

### Optional — defined tags

If you set `defined_tags`, also grant:

```text
Allow group <orm-users> to use tag-namespaces in tenancy
```

> **Tenancy administrators** already have all of the above. Use the explicit
> policy statements when delegating the deployment to a non-admin group.

---

## Deploy the Resource Manager stack

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/aszynkow/oci_iac_exacc/raw/main/downloads/release/0.0.1/oci_iac_exacc-rm-stack-0.0.1.zip)

Stack artifact: [downloads/release/0.0.1/oci_iac_exacc-rm-stack-0.0.1.zip](downloads/release/0.0.1/oci_iac_exacc-rm-stack-0.0.1.zip).

### Steps

1. Click **Deploy to Oracle Cloud** above. You will land in the OCI console at
   *Resource Manager → Create Stack*, with the zip pre-selected.
2. **Stack information**
   - Give the stack a name, for example `exacc-vm-cluster`.
   - Pick the **compartment** where the stack itself will live.
   - Click **Next**.
3. **Configure variables** (driven by `terraform/schema.yaml`):
   - **VM Cluster Deployment Compartment** — where the VM cluster will be
     created.
   - **ExaCC Infrastructure Compartment** — where the existing ExaCC infra
     lives. May be the same compartment as the deployment.
   - **ExaCC Infrastructure** *(optional)* — pin a specific infrastructure
     OCID. Leave empty to auto-pick the first one in the ExaCC compartment.
   - **VM Cluster Network OCID** *(optional)* — pin a specific VM cluster
     network OCID. Leave empty to auto-pick the first one under the resolved
     infrastructure.
   - **Display Name**, **CPU Core Count**, **Data / DB Node Storage**,
     **Memory**, **Grid Infrastructure Version**.
   - **License Model** — `BRING_YOUR_OWN_LICENSE` or `LICENSE_INCLUDED`.
   - **Enable Local Backup** / **Enable Sparse Disk Group** *(optional)*.
   - **SSH Public Keys** — paste or upload at least one public key.
   - Click **Next**.
4. **Review** the plan summary, then click **Create**.
5. Either tick **Run apply** on the create dialog, or open the new stack and
   click **Apply**.
6. When the apply job finishes, the **Outputs** tab shows
   `vm_cluster_id`, `exadata_infrastructure_id`, and the other resolved IDs.

### Tearing down

From the stack page, click **Destroy** → **Destroy**. This removes the VM
cluster only — the ExaCC infrastructure, network, and DB servers are left
untouched because they are not managed by this stack.

---

## Stack inputs

The full list is in [`terraform/variables.tf`](terraform/variables.tf). The
important ones:

| Variable | Required | Default | Purpose |
| --- | --- | --- | --- |
| `compartment_ocid` | yes | — | Compartment where the VM cluster will be created. |
| `exacs_compartment_id` | yes | — | Compartment that holds the existing ExaCC infrastructure / DB servers / network. |
| `exadata_infrastructure_id` | no | first in compartment | Pin a specific ExaCC infrastructure OCID. |
| `vm_cluster_network_id` | no | first under infra | Pin a specific VM cluster network OCID. |
| `vm_cluster_display_name` | yes | `tmptest1` | Display name for the cluster. |
| `vm_cluster_cpu_core_count` | yes | `4` | Enabled CPU cores. |
| `vm_cluster_data_storage_size_in_tbs` | no | `3` | Data storage size in TB. |
| `vm_cluster_db_node_storage_size_in_gbs` | no | `160` | DB node storage in GB. |
| `vm_cluster_memory_size_in_gbs` | no | `60` | Memory in GB. |
| `vm_cluster_gi_version` | yes | `19.0.0.0` | Grid Infrastructure version. |
| `vm_cluster_license_model` | no | `BRING_YOUR_OWN_LICENSE` | `BRING_YOUR_OWN_LICENSE` or `LICENSE_INCLUDED`. |
| `vm_cluster_is_local_backup_enabled` | no | `false` | Enable local backup. |
| `vm_cluster_is_sparse_diskgroup_enabled` | no | `false` | Enable sparse disk groups. |
| `vm_cluster_ssh_public_keys` | yes | — | One or more SSH public keys (comma-separated when entered as a single string). |
| `defined_tags` / `freeform_tags` | no | `{}` | Tags applied to the VM cluster. |

---

## Stack outputs

| Output | Description |
| --- | --- |
| `stack_name` | Logical name of this stack (`oci_iac_exacc`). |
| `compartment_ocid` | Target compartment for the VM cluster. |
| `vm_cluster_id` | OCID of the newly created ExaCC VM cluster. |
| `exadata_infrastructure_id` | OCID of the ExaCC infrastructure that was used (provided or discovered). |
| `vm_cluster_network_id` | OCID of the VM cluster network that was used (provided or discovered). |
| `availability_domain` | Name of the AD-1 availability domain resolved by the stack. |

---

## Repository layout

```text
.
|-- terraform/
|   |-- main.tf          # locals: name + ID resolution between provided / discovered values
|   |-- datasources.tf   # ExaCC infrastructure, DB servers, VM cluster network, AD lookups
|   |-- vm_cluster.tf    # oci_database_vm_cluster resource
|   |-- variables.tf     # input variables
|   |-- outputs.tf       # exported OCIDs and resolved names
|   |-- schema.yaml      # ORM UI schema (variable groups, LOV pickers)
|   |-- versions.tf      # required Terraform + provider versions
|   `-- terraform.tfvars # example local values (not used by ORM)
|-- downloads/
|   `-- release/<version>/oci_iac_exacc-rm-stack-<version>.zip   # ORM stack packages
`-- LICENSE
```

Release folders are versioned so future ORM stack packages can be published
under new paths such as `downloads/release/0.0.2/`.
