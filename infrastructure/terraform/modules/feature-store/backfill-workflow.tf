 
# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  tagList    = join("\n", formatlist("            - %s", var.includedTags))
  tagSection = length(var.includedTags) == 0 ? "" : "\n            includedTags:\n${local.tagList}"
  adsDataVariable = jsonencode(var.source_ads_export_data)
}

resource "google_workflows_workflow" "customer-ltv-backfill-workflow" {
  project         = var.project_id
  name            = "customer-ltv-${var.environment}-backfill"
  region          = var.region
  description     = "Customer LTV backfill workflow for ${var.environment} environment"
  service_account = google_service_account.workflow-dataform.email
  source_contents = <<-EOF
main:
steps:
- init:
    assign:
        - results : {} # result from each iteration keyed by table name
        - procedures:
            - invoke_backfill_customer_lifetime_value_label
            - invoke_backfill_user_lifetime_dimensions
            - invoke_backfill_user_rolling_window_lifetime_metrics
            - invoke_backfill_user_scoped_lifetime_metrics
- runQueries:
    for:
        value: procedure
        in: ${procedures}
        steps:
        - runProcedure:
            call: googleapis.bigquery.v2.jobs.query
            args:
                projectId: ${sys.get_env("GOOGLE_CLOUD_PROJECT_ID")}
                body:
                    useLegacySql: false
                    useQueryCache: false
                    timeoutMs: 30000
                    query: ${
                        "CALL `feature_store." + procedure + "`()"
                        }
            result: queryResult
        - returnResult:
            assign:
                # Return
                - results[procedure]: {}
                - results[procedure].name: ${procedure}
                - results[procedure].jobid: ${queryResult.jobReference.jobId}
- returnResults:
    return: ${results}
EOF
}


resource "google_workflows_workflow" "purchase-propensity-backfill-workflow" {
  project         = var.project_id
  name            = "purchase-propensity-${var.environment}-backfill"
  region          = var.region
  description     = "Purchase propensity backfill workflow for ${var.environment} environment"
  service_account = google_service_account.workflow-dataform.email
  source_contents = <<-EOF
main:
steps:
- init:
    assign:
        - results : {} # result from each iteration keyed by table name
        - procedures:
            - invoke_backfill_purchase_propensity_label
            - invoke_backfill_user_dimensions
            - invoke_backfill_user_rolling_window_metrics
            - invoke_backfill_user_scoped_metrics
            - invoke_backfill_user_session_event_aggregated_metrics
- runQueries:
    for:
        value: procedure
        in: ${procedures}
        steps:
        - runProcedure:
            call: googleapis.bigquery.v2.jobs.query
            args:
                projectId: ${sys.get_env("GOOGLE_CLOUD_PROJECT_ID")}
                body:
                    useLegacySql: false
                    useQueryCache: false
                    timeoutMs: 30000
                    query: ${
                        "CALL `feature_store." + procedure + "`()"
                        }
            result: queryResult
        - returnResult:
            assign:
                # Return
                - results[procedure]: {}
                - results[procedure].name: ${procedure}
                - results[procedure].jobid: ${queryResult.jobReference.jobId}
- returnResults:
    return: ${results}
EOF
}


resource "google_workflows_workflow" "audience-segmentation-backfill-workflow" {
  project         = var.project_id
  name            = "audience-segmentation-${var.environment}-backfill"
  region          = var.region
  description     = "Audience segmentation backfill workflow for ${var.environment} environment"
  service_account = google_service_account.workflow-dataform.email
  source_contents = <<-EOF
main:
steps:
- init:
    assign:
        - results : {} # result from each iteration keyed by table name
        - procedures:
            - invoke_backfill_user_segmentation_dimensions
            - invoke_backfill_user_lookback_metrics
            - invoke_backfill_user_scoped_segmentation_metrics
- runQueries:
    for:
        value: procedure
        in: ${procedures}
        steps:
        - runProcedure:
            call: googleapis.bigquery.v2.jobs.query
            args:
                projectId: ${sys.get_env("GOOGLE_CLOUD_PROJECT_ID")}
                body:
                    useLegacySql: false
                    useQueryCache: false
                    timeoutMs: 30000
                    query: ${
                        "CALL `feature_store." + procedure + "`()"
                        }
            result: queryResult
        - returnResult:
            assign:
                # Return
                - results[procedure]: {}
                - results[procedure].name: ${procedure}
                - results[procedure].jobid: ${queryResult.jobReference.jobId}
- returnResults:
    return: ${results}
EOF
}
