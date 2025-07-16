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

