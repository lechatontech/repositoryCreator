module "project" {
  source          = "github.com/lechatontech/repositoryCreator//src/terraform/modules/azure_github_repo?ref=dev"
  project_code    = "ARD"
  repository_name = "azureRepoDemo"
}



