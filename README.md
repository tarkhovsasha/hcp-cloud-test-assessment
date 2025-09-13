# hcp-cloud-test-assessment
Technical assessment for HCP Terraform 09/25


In this repo, you'll find a quick and easy way to demonstrate the use of Terraform TFE provider to set up HCP (Hashicorp Cloud) Terraform and integrate it with a Github repo.   
This code is prepared for technical assessment.

## What's here?

This repo contains:

1. An example Terraform configuration which provisions your pre-existing HCP Terraform organization adding few new workspaces, and integrates one of the workspaces to a pre-existing Github repo.
2. This instruction guide to get you started with the testing


## Requirements

- Terraform 1.12 or higher
- Existing HCP Terraform account and organization
- Note the name of organization
- HCP Terraform API token
- GitHub account 
- GitHub repo owned by your account
- GitHub App token for HCP to be able to access the repo

If you don't have HCP Terraform organization yet, you need to create a new one.
Login to your HCP Terraform account - https://app.terraform.io 
- Navigate to Organizations -> Create organization

![Create a new organization](https://github.com/tarkhovsasha/hcp-cloud-test-assessment/blob/main/blob/hcp_create_org.png?raw=true)

If you haven't authorized HCP with GitHub App OAuth, you need to authorize it.
- navigate to your new Organization -> Settings -> Version Control: Providers 
- click **Add a VCS Provider**
- Select **GitHub App** as your VCS provider and follow steps to authorize with GitHub

![Authorize HCP with GitHub App](https://github.com/tarkhovsasha/hcp-cloud-test-assessment/blob/main/blob/configure_GitHub_app_as_VCS_provider.png?raw=true)

Save the **GitHub App Installation Id** - this is your access key.
If you previously authorized HCP Terraform with GitHub App, you can find the GitHub App Installation Id in Account Settigs -> Tokens under Github App OAuth Token

## Usage

### 1. Log in to HCP Terraform via the CLI

Run `terraform login` and follow the prompts to provide API token for Terraform to use. If you don't have a HCP Terraform API token, you can create one during this step.

### 2. Clone this repo

```sh
git clone https://github.com/tarkhovsasha/hcp-cloud-test-assessment.git
cd hcp-cloud-test-assessment
```

### 3. Set the following required ENV variables in your shell

```sh
export TF_VAR_github_app_installation_id='<your_github_app_installation_id_here>'
export TF_VAR_aws_access_key_id='TEST_DUMMY_KEY_ID'
export TF_VAR_aws_secret_access_key='TEST_DUMMY_SECRET'
export TF_VAR_github_user='your_github_user_path_here'
export TF_VAR_github_repo='your_github_repo_name_here'
export TF_VAR_organization_name='your_hcp_org_name_here'
```

GitHub branch is 'main' by default.
You may change it by setting:

```sh
export TF_VAR_vcs_repo_branch='<your_github_branch_here>'
```

It is recommended to leave default values for all other variables defined in variables.tf


### 4. Initialize directory 

Execute command `terraform init`

### 5. Execute Terraform plan and apply

Execute command `terraform plan`

Assuming plan was successfull, execute `terraform apply`
confirm run by typing yes


### 6. Navigate to HCP Terraform UI 

Assuming apply was successful, open your oranization in HCP Terraform UI
Check there were 4 new workspaces created

![Workspaces created via TFE provoder](https://github.com/tarkhovsasha/hcp-cloud-test-assessment/blob/main/blob/hcp_org_workspaces.png?raw=true)


Click on workspace `cli-team-jedi-ws` -> Variables
Check there is a variable set with three variables

![Variable set under CLI workspace](https://github.com/tarkhovsasha/hcp-cloud-test-assessment/blob/main/blob/hcp_workspace_variable_set.png?raw=true)


Return back to Workspaces
Click on workspace `vcs-the-force-ws` 

Navigate to Runs
Check there are runs triggered from VCS

![VCS triggered runs under VCS workspace](https://github.com/tarkhovsasha/hcp-cloud-test-assessment/blob/main/blob/hcp_vcs_workspace_runs.png?raw=true)


### 7. Optionally try to trigger a VCS run by commiting to the main branch in your VCS repo

Navigate to workspace `vcs-the-force-ws` -> Runs
Check there is a new runs triggered by GitHub commit
