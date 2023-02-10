terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.29.0"
    }
  }
}

# provider "confluent" {
#   cloud_api_key    = var.confluent_cloud_api_key
#   cloud_api_secret = var.confluent_cloud_api_secret
# }

resource "confluent_environment" "Terraform_Test" {
  display_name = "Terraform_Test"
}

# Stream Governance and Kafka clusters can be in different regions as well as different cloud providers,
# but you should to place both in the same cloud and region to restrict the fault isolation boundary.

resource "confluent_kafka_cluster" "basic" {
  display_name = "inventory"
  availability = "SINGLE_ZONE"
  cloud        = "AZURE"
  region       = "germanywestcentral"
  standard {}
  environment {
    id = confluent_environment.Terraform_Test.id
  }
}
