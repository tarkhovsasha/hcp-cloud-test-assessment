# Configure TFE provider
terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.65.0"
    }
  }
}

# Convert workspace names input to set
locals {
  cli_workspaces = toset(var.cli_workspaces_name_list)
}

# Create a project
resource "tfe_project" "galaxy" {
  organization = var.organization_name
  name         = "project-${var.project_name}"
}

# Create a workspace with VCS-driven workflow
resource "tfe_workspace" "vcs_ws" {
  
  name           = var.vcs_workspace_name
  organization   = var.organization_name
  project_id     = tfe_project.galaxy.id
  queue_all_runs = false
  auto_apply     = true

  vcs_repo {
    identifier = "${var.github_user}/${var.project_name}-repo"
    #oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
    github_app_installation_id = var.github_app_installation_id
    branch                     = var.vcs_repo_branch
  }
}

# Create 3 workspaces with CLI-driven workflow
resource "tfe_workspace" "cli_ws" {
  for_each = local.cli_workspaces

  name           = each.key
  organization   = var.organization_name
  project_id     = tfe_project.galaxy.id
  queue_all_runs = false
  auto_apply     = true
}


/* # Initialize and apply the HCP Terraform Simple Landing Zone module
module "tfc-simple-lz" {
  source = "./modules/tfc-simple-lz"

  app_name              = var.app_name
  aws_vpc_id            = module.aws-simple-lz.vpc_id
  aws_public_subnet_id  = module.aws-simple-lz.public_subnet_id
  aws_private_subnet_id = module.aws-simple-lz.private_subnet_id
  aws_s3_bucket_arn     = module.aws-simple-lz.s3_bucket_arn
  aws_access_key_id     = module.aws-simple-lz.aws_access_key_id
  aws_secret_access_key = module.aws-simple-lz.aws_secret_access_key
  gitlab_group_path     = var.gitlab_group_path
  oauth_client_id       = var.oauth_client_id
} */