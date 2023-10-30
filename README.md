# Community-2023-IaC-Demo
Infrastructure as Code/[Terraform](https://www.terraform.io/) Demo - [Atea Community Bergen 2023](https://www.atea.no/arrangementer/2023/community-bergen/)

# 1. Beginner

* [Get Started - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
* [Get Started - Azure](https://developer.hashicorp.com/terraform/tutorials/azure-get-started)
* [Terraform Registry](https://registry.terraform.io/)

# 2. Intermediate

* [Best practices for using Terraform](https://cloud.google.com/docs/terraform/best-practices-for-terraform) - Google's style guide for Terraform code. Most of the information in both this and the AWS I&A document is provider agnostic and can (or maybe even should) be used anywhere

* [The AWS Integration & Automation team's best practices for Terraform](https://aws-ia.github.io/standards-terraform/) - More or less the same as Google's version, but with AWS examples

* [Creating Modules](https://developer.hashicorp.com/terraform/language/modules/develop) - Standard module structure, including naming conventions and versioning that is important is code should be published in a Terraform Registry

# 3. Useful third-party tools

* [Checkov](https://github.com/bridgecrewio/checkov) and/or [tfsec](https://github.com/aquasecurity/tfsec) - Static code analysis to catch security problems and misconfiguration

* [tfenv](https://github.com/tfutils/tfenv) - Version manager to have multiple versions of Terraform installed for different projects

* [Infracost](https://github.com/infracost/infracost) - Create cost calculations for public cloud

* [tflint](https://github.com/terraform-linters/tflint) - Improved linting compared to running terraform validate and catch configuration errors that wont be discovered until running terraform apply. Requires adding the relevant plugin with rulesets for AWS/Azure/GCP

* [terraform-docs](https://terraform-docs.io/) - Auto-generated documentation. I use this to add information to the README file with input variables, outputs, dependencies and an overview of which resources Terraform creates

All of these tools can also be used together with [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform) to run checks before code changes is commited to git (instead of waiting for the CI/CD pipeline to give you feedback)

# 4. Auto-generated Terraform docs
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.45.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.78.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.45.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.78.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend"></a> [backend](#module\_backend) | ./modules/linuxvm | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_webserver"></a> [webserver](#module\_webserver) | ./modules/linuxvm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.demo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azuread_user.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Default region in Azure for resources | `string` | `"westeurope"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->