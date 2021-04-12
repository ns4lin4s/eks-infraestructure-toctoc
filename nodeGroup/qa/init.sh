#!/bin/sh
echo "********************************************************************************************"
echo Creando NodeGroup toctoc-shell
aws eks create-nodegroup --region us-east-1 --cluster-name demo --nodegroup-name toctoc-shell --scaling-config minSize=1,maxSize=3,desiredSize=1 --disk-size 20 --subnets subnet-03bb92a3cd8780dc9 subnet-0e57b92a7ce40799d subnet-05140137e07601945 --instance-types "t3.large" --ami-type "AL2_x86_64" --remote-access ec2SshKey=aws-eks --node-role arn:aws:iam::573624488707:role/eks-node-group-instance-role-NodeInstanceRole-HWNSRM4EECJ9 --tags Responsable=Marcelo-Diaz,Criticidad=Baja,Plataforma=toctoc,Version=Beta,Funcionalidad=sitio-toctoc --label host=toctoc-shell
echo "********************************************************************************************"
echo "********************************************************************************************"
echo Esperando a que se encuentre en estado ACTIVADO
aws eks wait nodegroup-active --cluster-name demo --nodegroup-name toctoc-shell
echo ESTADO = ACTIVADO