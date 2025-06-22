terraform {
  required_version = "~>1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~>2.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_440497ff9976b6da78ab64058d86a8d267ce51d91290661f7246f99235cfe3f5"
}

resource "digitalocean_kubernetes_cluster" "k8s-cluster" {
  name    = "k8s-cluster"
  region  = "nyc1"
  version = "latest"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3

  }
}
output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.k8s-cluster.kube_config[0].raw_config
  sensitive = true
}
