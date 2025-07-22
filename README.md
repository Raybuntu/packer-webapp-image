# WebApp Packer Image Build

This project uses HashiCorp Packer to build a custom Google Compute Engine image that installs and configures a web application.

## Structure

- `cloudbuild.yaml`: Defines the Cloud Build steps to initialize and run the Packer build.
- `main.pkr.hcl`: Main Packer configuration using the Google Compute plugin.
- `variables.pkr.hcl`: Variables used in the Packer configuration.
- `scripts/setup_webapp.sh`: Installs dependencies, configures the application, and sets up services.
- `scripts/cleanup.sh`: Cleans up temporary files after provisioning.
- `LICENSE`: MIT License for this project.

## Requirements

- Google Cloud project and access to Cloud Build
- Enable the Compute Engine API
- Set the following substitution variables when triggering the build:
  - `_PROJECT_ID`
  - `_ZONE`
  - `_WEBAPP_GIT_REPO_URL`
  - `_WEBAPP_GIT_SHA`

## Usage

Trigger the build using Cloud Build with the required substitution variables. The process will:

1. Use a base Ubuntu 22.04 LTS image.
2. Clone the specified Git repository.
3. Checkout the specified commit SHA.
4. Install dependencies and configure services.
5. Build and output a new GCE image.

The resulting image will be added to the specified image family.

## License

This project is licensed under the MIT License.

