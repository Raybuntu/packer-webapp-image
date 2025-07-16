packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "webapp" {
  project_id  = var.project_id
  zone        = var.zone
  machine_type = "e2-micro"
  source_image_family = "ubuntu-2404-lts"
  image_name          = "webapp-image-{{timestamp}}"
  image_family        = "webapp-family"
  ssh_username        = "packer"
}

build {
  sources = ["source.googlecompute.webapp"]

  provisioner "shell" {
    script = "scripts/setup_webapp.sh"

    environment_vars = [
      "WEBAPP_REPO_URL=${var.webapp_git_repo_url}"
    ]
  }

  provisioner "shell" {
    script = "scripts/cleanup.sh"
  }
}
