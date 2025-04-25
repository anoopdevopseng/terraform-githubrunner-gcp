terraform {
  required_version = ">= 1.0"

  required_providers {

    google = {
      source  = "hashicorp/google"
      version = ">= 4.3.0, < 7"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    
  }
}