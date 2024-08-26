module "project" {
  source          = "github.com/lechatontech/repositoryCreator//src/terraform/modules/azure_github_repo?ref=dev"
  project_code    = "bimbam"
  repository_name = "bimbam"
}



