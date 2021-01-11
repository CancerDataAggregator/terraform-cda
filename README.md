[![Terraform Apply](https://github.com/CancerDataAggregator/terraform-cda/workflows/Terraform%20Apply/badge.svg)](https://github.com/CancerDataAggregator/terraform-cda/actions?query=workflow%3A%22Terraform+Apply%22)

# terraform-cda

Terraform code to setup various GCP environments for the CDA service layer.

## Quickstart

### Generate `.vault-token`

You may need to generate or update `~/.vault-token`. If your github token is at `~/.github-token`, you can
run

```sh
vault login -method=github token=$(cat ~/.github-token)
```

For more information, see [GitHub Auth Method](https://www.vaultproject.io/docs/auth/github)

### Run Terraform

```sh
git clone https://github.com/CancerDataAggregator/terraform-cda.git
cd cda
docker run --rm -it -v "$PWD":/working -v ${HOME}/.vault-token:/root/.vault-token broadinstitute/dsde-toolbox:consul-0.20.0 ./mkEnv.sh -e <env>
./terraform.sh init -backend-config=bucket=broad-cda-dev
./terraform.sh plan -var-file=tfvars/dev.tfvars
./terraform.sh apply -var-file=tfvars/dev.tfvars
```
## Notes
- Only `dev` is supported currently

## Github Actions
- On PR a terraform plan will be made for the following environments [`[dev]`](https://github.com/CancerDataAggregator/terraform-cda/blob/main/.github/workflows/terraformPrPlan.yml#L17)
- On merge a terraform Apply will be made for the following environments [`[dev]`](https://github.com/CancerDataAggregator/terraform-cda/blob/main/.github/workflows/terraformMergeApply.yml#L18)
- To not plan or apply changes add the label `skip-ci` to your PR
