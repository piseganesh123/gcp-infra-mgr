// Create VM for Ansible host
// Configure the Google Cloud provider

variable "project_id" {
  type = string
  default = "level-surfer-357407"
}

provider "google" {
 project     = var.project_id
 region      = "asia-south1"
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 // name         = "prografana-poc-vm-${random_id.instance_id.hex}"
 name = "infra-mgr"
 machine_type = "e2-small"
 zone         = "asia-south1-c"
 //tags = ["allow-grafana-ingress-3000", "allow-prometheus-ingress-9090"]
 labels = {
   "purpose" = "poc"
   "preserve" = "no"
 }
 boot_disk {
   initialize_params {
     image = "ubuntu-1804-bionic-v20210720"
   }
 }

// 
// metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync"
metadata_startup_script = file("config-tools.sh")

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}
