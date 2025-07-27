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

variable "webapp_git_sha" {
  type    = string
  description = "Git SHA for our Repo"
}

variable "packer_vm_sa_email" {
  type        = string
  description = "Email of the Service Account used by the Packer VM to create images"
}
