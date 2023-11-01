

AutoML Tabular Workflows

Pipeline Arguments:

* project: The GCP project that runs the pipeline components.
* location: The GCP region that runs the pipeline components.
* root_dir: The root GCS directory for the pipeline components.
* target_column: The target column name.
* prediction_type: The type of prediction the model is to produce: "classification" or "regression".
* optimization_objective: 
   * For binary classification, "maximize-au-roc",
    "minimize-log-loss", "maximize-au-prc", "maximize-precision-at-recall", or
    "maximize-recall-at-precision". 
    * For multi class classification,
    "minimize-log-loss". 
    * For regression, "minimize-rmse", "minimize-mae", or
    "minimize-rmsle".
* transformations: The path to a GCS file containing the transformations to apply.
* train_budget_milli_node_hours: The train budget of creating this model, expressed in milli node hours i.e. 1,000 value in this field means 1 node hour.
* stage_1_num_parallel_trials: Number of parallel trails for stage 1.
* stage_2_num_parallel_trials: Number of parallel trails for stage 2.
* stage_2_num_selected_trials: Number of selected trials for stage 2.
* data_source_csv_filenames: The CSV data source.
* data_source_bigquery_table_path: The BigQuery data source.
* predefined_split_key: The predefined_split column name.
* timestamp_split_key: The timestamp_split column name.
* stratified_split_key: The stratified_split column name.
* training_fraction: The training fraction.
* validation_fraction: The validation fraction.
* test_fraction: float = The test fraction.
* weight_column: The weight column name.
* study_spec_parameters_override: The list for overriding study spec. The list should be of format
https://github.com/googleapis/googleapis/blob/4e836c7c257e3e20b1de14d470993a2b1f4736a8/google/cloud/aiplatform/v1beta1/study.proto#L181.
* optimization_objective_recall_value: Required when optimization_objective is "maximize-precision-at-recall". Must be between 0 and 1, inclusive.
* optimization_objective_precision_value: Required when optimization_objective is "maximize-recall-at-precision". Must be between 0 and 1, inclusive.
* stage_1_tuner_worker_pool_specs_override: The dictionary for overriding stage 1 tuner worker pool spec. The dictionary should be of format
https://github.com/googleapis/googleapis/blob/4e836c7c257e3e20b1de14d470993a2b1f4736a8/google/cloud/aiplatform/v1beta1/custom_job.proto#L172.
* cv_trainer_worker_pool_specs_override: The dictionary for overriding stage cv trainer worker pool spec. The dictionary should be of format
https://github.com/googleapis/googleapis/blob/4e836c7c257e3e20b1de14d470993a2b1f4736a8/google/cloud/aiplatform/v1beta1/custom_job.proto#L172.
* export_additional_model_without_custom_ops: Whether to export additional model without custom TensorFlow operators.
* stats_and_example_gen_dataflow_machine_type: The dataflow machine type for stats_and_example_gen component.
* stats_and_example_gen_dataflow_max_num_workers: The max number of Dataflow workers for stats_and_example_gen component.
* stats_and_example_gen_dataflow_disk_size_gb: Dataflow worker's disk size in GB for stats_and_example_gen component.
* transform_dataflow_machine_type: The dataflow machine type for transform component.
* transform_dataflow_max_num_workers: The max number of Dataflow workers for transform component.
* transform_dataflow_disk_size_gb: Dataflow worker's disk size in GB for transform component.
* dataflow_subnetwork: Dataflow's fully qualified subnetwork name, when empty
the default subnetwork will be used. Example:
https://cloud.google.com/dataflow/docs/guides/specifying-networks#example_network_and_subnetwork_specifications
* dataflow_use_public_ips: Specifies whether Dataflow workers use public IP addresses.
* encryption_spec_key_name: The KMS key name.
* additional_experiments: Use this field to config private preview features.
* dataflow_service_account: Custom service account to run dataflow jobs.
* run_evaluation: Whether to run evaluation in the training pipeline.
* evaluation_batch_predict_machine_type: The prediction server machine type for batch predict components during evaluation.
* evaluation_batch_predict_starting_replica_count: The initial number of prediction server for batch predict components during evaluation.
* evaluation_batch_predict_max_replica_count: The max number of prediction server for batch predict components during evaluation.
* evaluation_batch_explain_machine_type: The prediction server machine type for batch explain components during evaluation.
* evaluation_batch_explain_starting_replica_count: The initial number of prediction server for batch explain components during evaluation.
* evaluation_batch_explain_max_replica_count: The max number of prediction server for batch explain components during evaluation.
* evaluation_dataflow_machine_type: The dataflow machine type for evaluation components.
* evaluation_dataflow_starting_num_workers: The initial number of Dataflow workers for evaluation components.
* evaluation_dataflow_max_num_workers: The max number of Dataflow workers for evaluation components.
* evaluation_dataflow_disk_size_gb: Dataflow worker's disk size in GB for evaluation components.
* max_selected_features: number of features to select for training,
* apply_feature_selection_tuning: tuning feature selection rate if true.
* run_distillation: Whether to run distill in the training pipeline.
* distill_batch_predict_machine_type: The prediction server machine type for batch predict component in the model distillation.
* distill_batch_predict_starting_replica_count: The initial number of prediction server for batch predict component in the model distillation.
* distill_batch_predict_max_replica_count: The max number of prediction server for batch predict component in the model distillation.
* model_display_name: The display name of the uploaded Vertex model.
* model_description: The description for the uploaded model.