# fg-assess Terraform Project

## Introduction

Welcome to the `fg-assess` Terraform project. This repository contains Terraform code for setting up AWS network infrastructure, including VPCs, subnets, security groups, and more.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Terraform installed (preferably version 0.12.26 or later)
- AWS CLI installed and configured
- AWS account with necessary permissions

## Installation

1. Clone the repository and navigate to the project directory:

bash
git clone https://github.com/rajaroraji/fg-assess.git
cd fg-assess


2. Configure the Terraform code by setting up necessary variables in `vars/dev.tfvars` and backend configuration in `backend/dev/vpc.tfvars`.

## Usage

1. Initialize Terraform:

```
terraform init -backend-config=backend/dev/vpc.tfvars
```

2. Review the plan:

```
terraform plan -var-file=vars/dev.tfvars
```

3. Apply the configuration:

```
terraform apply -var-file=vars/dev.tfvars
```

## Modules

The project is structured into multiple modules for better management and reusability. These modules include:

- VPC (`modules/network/vpc`)
- Subnets (`modules/network/subnet`)
- Security Groups (`modules/network/sg`)

## Contributing

Contributions to the fg-assess project are welcome! Here's how you can contribute:

1. Fork the repository.
2. Create a new branch (e.g., `git checkout -b feature-branch`).
3. Make your changes and commit them (e.g., `git commit -am 'Add some feature'`).
4. Push to the branch (e.g., `git push origin feature-branch`).
5. Create a new Pull Request.
