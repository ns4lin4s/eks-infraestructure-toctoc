#!/bin/sh

echo "********************************************************************************************"

echo Eliminado NodeGroup toctoc-shell

aws eks delete-nodegroup --region us-east-1 --cluster-name demo --nodegroup-name toctoc-shell

echo "********************************************************************************************"

echo "********************************************************************************************"

echo Cuando se cierre el proceso terminara de eliminar el NodeGroup

aws eks wait nodegroup-deleted --region us-east-1 --cluster-name demo --nodegroup-name toctoc-shell

echo "********************************************************************************************"