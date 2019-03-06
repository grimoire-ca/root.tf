# Grimoire.ca Root Terraform Configuration

This repository holds the configuration needed to set up Terraform:

* A bucket to hold terraform state.

As this is the bootstrap manifest, the state is stored in this repository as a `.tfstate` file. Changes to this file must be coordinated carefully.

Applying these manifests assumes the caller has an IAM account in the target AWS account that can at least create and manage S3 buckets. In practice, an administrative user is strongly encouraged.

## Configuring Downstream Projects

The bucket created by this project can be used as a state backend for other projects. To configure a project to use this bucket, the manifest must  configure the `s3` provider as follows:

```terraform
terraform {
  backend "s3" {
    bucket = "terraform.grimoire"
    key    = "my-project.tfstate"
    region = "ca-central-1"
  }
}
```

The user running Terraform must also have access to the `terraform.grimoire` bucket. In practice, an administrative user is strongly encouraged.

Replace `my-project` with a key unique to the project.

## Tagging

This project tags its objects with `Project = "root.tf"`, matching the
canonical base name of the Git repository. This convention is intended to help
with billing and with tracking down the source of rogue objects. It is strongly
recommended that downstream projects follow suit.
