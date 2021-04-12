#!/bin/sh
echo "********************************************************************************************"
echo Buscando la ultima IP del EC2 ingresada al Grupo de Seguridad
#Elimina la ultima ip ingresada en el grupo de seguridad del ec2 creada por el nodegroup
aws ec2 describe-security-groups --region sa-east-1 --group-ids sg-86c5f5e2 --query 'SecurityGroups[*].IpPermissions[*].IpRanges' --output text | grep 'EKS' >> sgls.txt
export DELETE_IP=$(grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' sgls.txt)
echo $DELETE_IP
rm sgls.txt
echo "********************************************************************************************"

echo "********************************************************************************************"
echo Eliminando la IP
aws ec2 revoke-security-group-ingress --region sa-east-1 --group-id sg-86c5f5e2 --protocol tcp --port 1433 --cidr $DELETE_IP/32
echo "********************************************************************************************"

echo "********************************************************************************************"
echo Si esta vacio esta bien
#Verifica si aun hay alguna ip antigua con la descripcion de "EKS"
aws ec2 describe-security-groups --region sa-east-1 --group-ids sg-86c5f5e2 --query 'SecurityGroups[*].IpPermissions[*].IpRanges' --output text | grep 'EKS'
echo "********************************************************************************************"
echo "********************************************************************************************"
echo "********************************************************************************************"
echo "********************************************************************************************"
echo "********************************************************************************************"
echo Buscando la IP del EC2
#Obtiene la ip de la EC2 creada por el nodegroup
export IP=$(aws ec2 describe-instances --region us-east-1 --filter 'Name=tag:eks:nodegroup-name,Values=toctoc-shell' --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)
echo "********************************************************************************************"

echo "********************************************************************************************"
echo Ingresando la IP del EC2 al Grupo de Seguridad
#Ingresa la ip al grupo de seguridad
aws ec2 authorize-security-group-ingress --region sa-east-1 --group-id sg-86c5f5e2 --ip-permissions IpProtocol=tcp,FromPort=1433,ToPort=1433,IpRanges='[{CidrIp= '$IP'/32,Description="EKS qa"}]'
echo "********************************************************************************************"

echo "********************************************************************************************"
echo Muestra que se ingreso correctamente la IP del Ec2 al Grupo de Seguridad
#Lista todas las ips del grupo de seguridad para obtener
aws ec2 describe-security-groups --region sa-east-1 --group-ids sg-86c5f5e2 --query 'SecurityGroups[*].IpPermissions[*].IpRanges' --output text | grep 'EKS'
echo "********************************************************************************************"