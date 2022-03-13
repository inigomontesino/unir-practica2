ansible-playbook -i hosts 00-commons.yaml
ansible-playbook -i hosts 01-nfs.yaml
ansible-playbook -i hosts 02-k8s_commons.yaml
ansible-playbook -i hosts 03-k8s.yaml
ansible-playbook -i hosts 04-deploy_app.yaml