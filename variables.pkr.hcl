variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "zone" {
  type        = string
  description = "Specific zone for the image build"
}

variable "webapp_git_repo_url" {
  type    = string
  description = "Git URL for our Repo"
}

variable "region" {
  type        = string
  description = "Region of the MIG"
}

variable "mig_name" {
  type        = string
  description = "Name of the Managed Instance Group"
}
