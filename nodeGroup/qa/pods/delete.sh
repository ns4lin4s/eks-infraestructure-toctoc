echo "init delete toctoc:qa"
	docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 573624488707.dkr.ecr.us-east-1.amazonaws.com

    echo "nginx"
	kubectl delete deploy/nginx

    kubectl delete service/nginx
	echo "success deleted nginx"

    echo "backend"
	kubectl delete deploy/toctoc-nuevo
    kubectl delete deploy/toctoc-entorno
    kubectl delete deploy/toctoc-usado
    kubectl delete deploy/ventas-backend
    kubectl delete deploy/ventas-graphql

    kubectl delete service/toctoc-entorno
    kubectl delete service/toctoc-nuevo
    kubectl delete service/toctoc-usado
    kubectl delete service/ventas-backend
    kubectl delete service/ventas-graphql
	echo "success deleted backend"

	echo "toctoc"
	kubectl delete deploy/toctoc-server
    kubectl delete deploy/toctoc-redis

    kubectl delete service/toctoc-server
    kubectl delete service/toctoc-redis
	echo "success deleted toctoc"

	echo "ventas"
	kubectl delete deploy/ventas-frontend

    kubectl delete service/ventas-frontend
	echo "success deleted ventas"

    echo "toctoc-login"
    kubectl delete deploy/toctoc-login

    kubectl delete service/toctoc-login
	echo "success deleted toctoc-login"

    echo "portal-corredoras"
    kubectl delete deploy/portal-corredoras

    kubectl delete service/portal-corredoras
    echo "success deleted portal-corredoras"

    echo "urban-server"
    kubectl delete deploy/urban-server

    kubectl delete service/urban-server
    echo "success deleted urban-server"

    echo "oportunidades"
    kubectl delete deploy/oportunidades
    echo "success deleted oportunidades"

    echo "crons"
    kubectl delete cronjob carritoabandonado
	kubectl delete cronjob desactivarplanes
	kubectl delete cronjob destacadopropiedades
	kubectl delete cronjob enviorenovaciones
    kubectl delete cronjob correobienvenida
	kubectl delete cronjob oportunidades
    echo "success deleted crons"


echo "SUCCESS!"