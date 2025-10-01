locals {
	mgmt_address	= var.mgmt_address
	mgmt_username	= var.mgmt_username
	mgmt_password	= var.mgmt_password
	config_string	= var.config_string
}

resource "null_resource" "vyos_config" {
	connection {
		type		= "ssh"
		host		= local.mgmt_address
		user		= local.mgmt_username
		password	= local.mgmt_password
	}
	triggers = {
		config_string	= local.config_string
		mgmt_address	= local.mgmt_address
	}
	provisioner "file" {
		content		= local.config_string
		destination	= local.mgmt_address
	}
	provisioner "remote-exec" {
		inline = [<<-EOT
			#!/bin/vbash
			source /opt/vyatta/etc/functions/script-template
			source ~/config.cfg
			commit
			save
		EOT
		]
	}
}
