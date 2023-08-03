provider "vsphere" {
  user           = "seu_usuario"
  password       = "sua_senha"
  vsphere_server = "endereco_vcenter_ou_esxi"
  # Caso esteja usando ESXi diretamente (sem vCenter), descomente a linha abaixo
  # allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "seu_datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "seu_datastore"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "sua_rede"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "nome_da_vm"
  resource_pool_id = "ID_do_Resource_Pool"

  datastore_id = data.vsphere_datastore.datastore.id
  folder       = "vm"

  num_cpus = 2
  memory   = 4096

  guest_id = "ubuntu64Guest" # Substitua pelo ID do sistema operacional desejado

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  # Opções adicionais, como definir a ISO de instalação, podem ser adicionadas aqui
}
