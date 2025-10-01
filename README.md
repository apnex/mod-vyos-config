## SYN

Following example assumes a local vyos file `config.cfg` present (set syntax).  


### main.tf
```
locals {
	router_address	= "192.168.122.10"
}

module "router_config" {
	source		= "github.com/apnex/mod-vyos-config"
	mgmt_address	= local.router_address
	mgmt_username	= "vyos"
	mgmt_password	= "vyos"
	config_string	= file("config.cfg")
}
```

### apply
```
terraform init
terraform plan
terraform apply -auto-approve
```
