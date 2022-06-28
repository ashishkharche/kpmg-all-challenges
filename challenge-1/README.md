# Challenges #1

## Problem

A 3-tier environment is a common setup. Use a tool of your choosing/familiarity creates these resources. Please remember we will not be judged on the outcome but more focused on the approach, style and reproducibility.

## Solution

### Why Terraform

Terraform was chosen to code the infrastructure components. Terraform is a powerful tool for building, changing, and versioning infrastructure.

In configuration files, Terraform describes the components needed to run an application or your entire datacenter. It then executes the execution plan to reach the desired state. 

Terraform can detect changes in configuration, and create incremental execution plans that can be applied.

### Usecase of Terraform

Terraform has the ability to use both low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc.

Terraform is able to create, modify, and delete resources on infrastructure providers such as Amazon Web Services, Google Cloud Platform, Microsoft Azure, as well as PaaS and SaaS services.

With this feature, code can be ported across multiple cloud providers and standardized infrastructure can be built on any cloud.

### Configure AWS CLI

Refer to [Configuration basics - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) for detailed installation and configuration instructions for AWS CLI.

In short, you need to:

- Install AWS CLI on your local machine
- Create IAM user with proper policies
- Get the Access Key ID and secret access key of the IAM user
- On the commane line, execute "aws configure" and add the information requested. You may keep the region as default (recommended for this exercise) and keep output format as default

Now, proceed to Run Terraform.

### Run Terraform

Go to working directory (inside challenge-1) on a command line and execute following commands.

#### To initialize a working directory that contains Terraform configuration files, use the terraform init command.

```
terraform init
```

#### Terraform fmt is used to rewrite Terraform configuration files using a standard format and style.  

```
terraform fmt
```

#### The terraform validate command verifies the configuration files in a directory, referring only to the configuration files.

```
terraform validate
```

#### Terraform apply carries out the actions outlined in a Terraform plan.

```
terraform apply
```

Terraform apply is most easily used by running it without any arguments, which will trigger it to create an execution plan (as if you had run terraform plan) and require you to approve it before taking the indicated actions.

Enter the value "yes" when prompted on the command line to proceed with terraform execution plan.