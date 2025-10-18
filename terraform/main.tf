variable "PVE_WRK01" {
    type=string
}

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc03" 
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://pve-wrk01.nhay.es:8006/api2/json"
  pm_api_token_id = "terraform@pve!token"
  pm_api_token_secret = "${var.PVE_WRK01}"
  pm_tls_insecure = true # set false if you have valid certs
  pm_minimum_permission_check = false # Needed since VM.Monitor is no longer a permission
}

resource "proxmox_vm_qemu" "fedora_vm" {
  name        = "nhay-stack"
  target_node = "pve-wrk01"               # your proxmox node name
  clone       = "fedora-42-cloud-template"   # template name
  full_clone  = true
  agent = 1
  cpu {
    cores       = 2
    sockets     = 1
  }
  memory      = 4096
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsio0"
  
  # Cloud-init user-data
  ipconfig0 = "ip=dhcp"
  cicustom = "user=local:snippets/fedora-basic-user-data.yml"

  serial {
    id = 0
  }
  
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "8G" 
        }
      }
    }
    ide {
      ide1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  os_type = "cloud-init"

}