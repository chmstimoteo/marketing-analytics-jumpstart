# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This is a module that activates APIs services in the Cloud Project.
# https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest/submodules/project_services
module "data_processing_project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "18.0.0"

  disable_dependent_services  = false
  disable_services_on_destroy = false

  project_id = data.google_project.data_processing.project_id

  activate_apis = [
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "bigquery.googleapis.com",
    "bigquerystorage.googleapis.com",
    "dataform.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudasset.googleapis.com",
    "cloudfunctions.googleapis.com",
    "storage.googleapis.com",
    "datapipelines.googleapis.com",
    "analyticsadmin.googleapis.com",
  ]
}


# This resource executes gcloud commands to check whether the BigQuery API is enabled.
# Since enabling APIs can take a few seconds, we need to make the deployment wait until the API is enabled before resuming.
resource "null_resource" "check_bigquery_api" {
  provisioner "local-exec" {
    command = <<-EOT
    COUNTER=0
    MAX_TRIES=100
    while ! gcloud services list --project=${module.data_processing_project_services.project_id} | grep -i "bigquery.googleapis.com" && [ $COUNTER -lt $MAX_TRIES ]
    do
      sleep 6
      printf "."
      COUNTER=$((COUNTER + 1))
    done
    if [ $COUNTER -eq $MAX_TRIES ]; then
      echo "bigquery api is not enabled, terraform can not continue!"
      exit 1
    fi
    sleep 20
    EOT
  }

  depends_on = [
    module.data_processing_project_services
  ]
}

# This resource executes gcloud commands to check whether the Secret Manager API is enabled.
# Since enabling APIs can take a few seconds, we need to make the deployment wait until the API is enabled before resuming.
resource "null_resource" "check_secretmanager_api" {
  provisioner "local-exec" {
    command = <<-EOT
    COUNTER=0
    MAX_TRIES=100
    while ! gcloud services list --project=${module.data_processing_project_services.project_id} | grep -i "secretmanager.googleapis.com" && [ $COUNTER -lt $MAX_TRIES ]
    do
      sleep 6
      printf "."
      COUNTER=$((COUNTER + 1))
    done
    if [ $COUNTER -eq $MAX_TRIES ]; then
      echo "secret manager api is not enabled, terraform can not continue!"
      exit 1
    fi
    sleep 20
    EOT
  }

  depends_on = [
    module.data_processing_project_services
  ]
}


# This resource executes gcloud commands to check whether the Dataform API is enabled.
# Since enabling APIs can take a few seconds, we need to make the deployment wait until the API is enabled before resuming.
resource "null_resource" "check_dataform_api" {
  provisioner "local-exec" {
    command = <<-EOT
    COUNTER=0
    MAX_TRIES=100
    while ! gcloud services list --project=${module.data_processing_project_services.project_id} | grep -i "dataform.googleapis.com" && [ $COUNTER -lt $MAX_TRIES ]
    do
      sleep 6
      printf "."
      COUNTER=$((COUNTER + 1))
    done
    if [ $COUNTER -eq $MAX_TRIES ]; then
      echo "dataform api is not enabled, terraform can not continue!"
      exit 1
    fi
    sleep 20
    EOT
  }

  depends_on = [
    module.data_processing_project_services
  ]
}
