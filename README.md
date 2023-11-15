# fg-assess Terraform Project

## Introduction

Welcome to the fg-assess Terraform project. This repository contains Terraform code for setting up AWS network infrastructure, including VPCs, subnets, security groups, alb,rds,ec2's and more. Additionally, it includes a Python script for instance discovery.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Terraform installed (preferably version 0.12.26 or later)
- AWS CLI installed and configured
- AWS account with necessary permissions

## Folder Structure
The project follows a structured folder layout to enhance organization:

terraform/ - Contains Terraform code for resource provisioning.
backend/ - Configuration for Terraform backend.
modules/ - Custom Terraform modules for different resources (e.g., VPC, Subnets, Security Groups).
orchestration/ - Orchestrates the deployment of resources.
scripts/ - Contains the Python script (instance-discovery.py) for instance discovery.
.github/workflows/ - Workflow configuration files for CI/CD to deploy terraform.

## Modules

The project is structured into multiple modules for better management and reusability. These modules include:

- VPC (`modules/network/vpc`)
- Subnets (`modules/network/subnet`)
- Security Groups (`modules/network/sg`)


## Installation

1. Clone the repository and navigate to the project directory:

bash
git clone https://github.com/rajaroraji/fg-assess.git
cd fg-assess


2. Configure the Terraform code by setting up necessary variables in `vars/dev.tfvars` and backend configuration in `backend/dev/vpc.tfvars`.

## Usage

use the Ci/Cd workflow in github actiosn or goto the orchestartion and needed resource and execute below commands

1. Initialize Terraform:

```
terraform init -backend-config=../../backend/dev/<backend-config-file>
```

2. Review the plan:

```
terraform plan -var-file=../../vars/dev.tfvars
```

3. Apply the configuration:

```
terraform apply -var-file=../../vars/dev.tfvars
```



## Contributing

Contributions to the fg-assess project are welcome! Here's how you can contribute:

1. Fork the repository.
2. Create a new branch (e.g., `git checkout -b feature-branch`).
3. Make your changes and commit them (e.g., `git commit -am 'Add some feature'`).
4. Push to the branch (e.g., `git push origin feature-branch`).
5. Create a new Pull Request.




## Python Script
The instance-discovery.py Python script is designed to assist with instance discovery within your AWS environment.