# terraform

Simple and Basic terraform execution steps.

**`Day-1:`**

1: First Need to Install Terraform and AWS

2: Need to Create a [main.t](http://main.th)f file 

- In [main.tf](http://main.tf) file mention provider
- Add resources what you want to create

3: Have to run bunch of terraform commands, will help to crate a infrastructure. 

1. **`terraform init` → will read the terraform files and initialised the configuration** 
2. **`terraform plan`  → Dry run, It will show you the changes your are applying on infrastructure** 
3. **`terraform apply` → Will Create apply configuration for creating infrastructure you mentioned on terraform file** 
4. **`terraform destroy` → I will delete the infrastructure that you created.**

4: Satefiles Basics

**`Day2:`**

**1: Providers:**

1. Single Region Provider
2. Multi Region Provider
3. Multi Clouds Provider

**2: Variables:**

1. Input Variable
    - If you want to pass some  information or values (eg: AMI_id, key_name and etc ..) to terraform is called Input Variable
2. Out Variable 
    - If you want terraform to print a particular value or info (eg: Public_ip , Private_ip and etc.. )in the out is called Output Variable
3. tf Vars (terraform.tfvars): (Dynamic variable purpose )
    
    **`NOTE: By default terraform will look in to terraform tf.vars.`**
    

3: Conditional expression

4: Build-in functions

**`Day3:`**

**1: Modules**  

**2: Terraform registry**

**`Day4:`**

**Terraform State**

**1: Statefile:**   

It will store the information of the infrastructure it has created.

- Advantages
    - Terraform will look in to Statefile to know the current infrastructure based on state file terraform will make changes or create a infrastructure.
- Drawbacks
    - It will store the sensitive( secrets, passwords, api tokens and etc..) information as well in satefile as well
    - Pushing the statefile to git repo is not good because its will access to people if git is compromised
    
    Note: To fix the Terraform statefile drawbacks there is concept called **`REMOTE BACKEND`**
    

2: **`Remote Backend:`**

- Stores the terraform statefile in remote host like S3 and etc…

**`Day5`**

**Provisioners**: 

- To Execute and implement some actions during the resource creation and destroy

why Provisioners: 

Types of 

- File
    - To copy the files
- remote_exec
    - To run the Linux Commands during the resource(ec2) creation
- local_exec
    - To copy the Terraform output to local file

**`Day6`**:

**Workspaces:**
Statefile is created for every or per environment 

Terraform Workspace Commands:

1: Terraform Workspace creation command:

- **terraform workspace new workspace_name**

2: Terraform Workspace Switch command 

- **terraform workspace select workspace_name**

3: To show or see the current Terraform workspace command

- **terraform workspace show**

4: Pass Var file to terraform 

- **terraform plan -var-file=var_file_name**

passing variables in workspaces in 2 ways

1: Create different terraform.tfvars file for different environments and pass to terraform apply 

2: Create **`type = map(string)`** in variables section or file  (I feel this this more automated)

**`Day7:`**

Secret Management 

Vault

Note: 

- To create a infrastructure we use key word called **resource** in [main.tf](http://main.tf) in terraform
- to retrive an information we use key word called **data** in [main.tf](http://main.tf) in terraform

Terraform-VPC

https://harshitdawar.medium.com/launching-a-vpc-with-public-private-subnet-nat-gateway-in-aws-using-terraform-99950c671ce9
