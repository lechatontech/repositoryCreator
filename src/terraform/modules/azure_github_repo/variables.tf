variable "repository_name" {
  type        = string
  description = "Name of the repository"
}

variable "project_code" {
  type        = string
  description = "Code of the project. Used for interpolation"
}

variable "location" {
  type        = string
  description = "Location of the Azure resources"
  default     = "NorthEurope"
}

variable "location_code" {
  type        = string
  description = "Location code of the Azure resources. Used for interpolation"
  default     = "neu"
}

variable "environments" {
  type        = set(string)
  description = "List of project environments"
  default     = ["dev", "prod"]
  validation {
    condition     = contains(var.environments, "dev")
    error_message = "A dev environment is mandatory. Are you going to test in production ?"
  }
}
