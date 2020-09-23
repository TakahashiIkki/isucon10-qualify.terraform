default:
	terraform apply -var-file=var.tfvars

apply:
	default

output:
	echo "[bench]\n[competitor]\n[allinone]" > hosts
	terraform output -json isucon_server_public_ip | jq -r '.[]' >> hosts
