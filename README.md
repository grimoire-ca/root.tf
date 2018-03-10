# Grimoire.ca Root Terraform Configuration

This repository holds the configuration needed to set up Terraform:

* A bucket to hold terraform state.

As this is the bootstrap manifest, the state is stored in this repository as a `.tfstate` file. Changes to this file must be coordinated carefully.

Applying these manifests assumes the caller has an IAM account in the target AWS account that can at least create and manage S3 buckets. In practice, an administrative user is strongly encouraged.
