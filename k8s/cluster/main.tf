terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.55.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_60531b30c287fcfec43d7ea2e0deb9877951235bf19d2e3f82eaca57add40794"
}

resource "digitalocean_kubernetes_cluster" "foo" {
  name   = "foo"
  region = "nyc1"
  version = "latest"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3

    taint {
      key    = "workloadKind"
      value  = "database"
      effect = "NoSchedule"
    }
  }
}
output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.foo.kube_config[0].raw_config
  sensitive = true
}
