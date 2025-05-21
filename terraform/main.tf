terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

resource "null_resource" "kind_cluster" {
  provisioner "local-exec" {
    command = "kind create cluster --config=kind-config.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kind delete cluster --name case-study"
  }

  triggers = {
    always_run = timestamp()
  }

}
