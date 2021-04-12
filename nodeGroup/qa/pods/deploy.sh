source ./settings.conf

echo "init nginx:qa"
	docker login -u AWS -p $(aws ecr get-login-password --region $REGION) $AWS_EKS

	echo "==============================================="

	echo "==================== ventas-backend ===================="
	docker build -t ventas-backend $PATH_BACKEND/ventas/backend/ -f $PATH_BACKEND/ventas/backend/dockerfile.qa
	docker tag ventas-backend:latest $AWS_EKS/ventas-backend:latest
	docker push $AWS_EKS/ventas-backend:latest

	kubectl delete deploy/ventas-backend
	# kubectl delete service/ventas-backend
	kubectl apply -f $EXPORTS/qa/deploy/ventas-backend.yaml
	# kubectl expose deployment ventas-backend --port=4501
	echo "success ventas-backend --port=4501 --host=toctoc-shell"

	echo "==================== ventas-graphql ===================="
	docker build -t ventas-graphql $PATH_BACKEND/ventas/graphql/ -f $PATH_BACKEND/ventas/graphql/dockerfile.qa
	docker tag ventas-graphql:latest $AWS_EKS/ventas-graphql:latest
	docker push $AWS_EKS/ventas-graphql:latest
	
	kubectl delete deploy/ventas-graphql
	# kubectl delete service/ventas-graphql
	kubectl apply -f $EXPORTS/qa/deploy/ventas-graphql.yaml
	# kubectl expose deployment ventas-graphql --port=4502
	echo "success ventas-graphql --port=4502 --host=toctoc-shell"

	echo "==================== toctoc-nuevo ===================="
	docker build -t toctoc-nuevo $PATH_BACKEND/urbanCenter-nuevo/ -f $PATH_BACKEND/urbanCenter-nuevo/dockerfile.qa
	docker tag toctoc-nuevo:latest $AWS_EKS/toctoc-nuevo:latest
	docker push $AWS_EKS/toctoc-nuevo:latest

	kubectl delete deploy/toctoc-nuevo
	# kubectl delete service/toctoc-nuevo
	kubectl apply -f $EXPORTS/qa/deploy/toctoc-nuevo.yaml
	# kubectl expose deployment toctoc-nuevo --port=80
	echo "success toctoc-nuevo --port=80 --host=toctoc-shell"

	echo "==================== toctoc-entorno ===================="
	docker build -t toctoc-entorno $PATH_BACKEND/urbanCenter-entorno/ -f $PATH_BACKEND/urbanCenter-entorno/dockerfile.qa
	docker tag toctoc-entorno:latest $AWS_EKS/toctoc-entorno:latest
	docker push $AWS_EKS/toctoc-entorno:latest

	kubectl delete deploy/toctoc-entorno
	# kubectl delete service/toctoc-entorno
	kubectl apply -f $EXPORTS/qa/deploy/toctoc-entorno.yaml
	# kubectl expose deployment toctoc-entorno --port=80
	echo "success toctoc-entorno --port=80 --host=toctoc-shell"

	echo "==================== toctoc-usado ===================="
	docker build -t toctoc-usado $PATH_BACKEND/urbanCenter-usado/ -f $PATH_BACKEND/urbanCenter-usado/dockerfile
	docker tag toctoc-usado:latest $AWS_EKS/toctoc-usado:latest
	docker push $AWS_EKS/toctoc-usado:latest

	kubectl delete deploy/toctoc-usado
	# kubectl delete service/toctoc-usado
	kubectl apply -f $EXPORTS/qa/deploy/toctoc-usado.yaml
	# kubectl expose deployment toctoc-usado --port=80
	echo "success usado --port=80 --host=corredoras"

	echo "==================== procesamiento ===================="
	docker build -t procesamiento $PATH_BACKEND/procesamiento/ -f $PATH_BACKEND/procesamiento/dockerfile
	docker tag procesamiento:latest $AWS_EKS/procesamiento:latest
	docker push $AWS_EKS/procesamiento:latest

	kubectl delete deploy/procesamiento
	# kubectl delete service/procesamiento
	kubectl apply -f $EXPORTS/qa/deploy/procesamiento.yaml
	kubectl expose deployment procesamiento --port=81
	echo "success procesamiento --port=81 --host=toctoc-shell"





	echo "==================== toctoc-redis ===================="
	kubectl delete deploy/toctoc-redis
	kubectl apply -f $EXPORTS/qa/deploy/toctoc/toctoc-redis.yaml
	# kubectl expose deployment toctoc-redis --port=6379
	echo "success toctoc-redis --port=6379 --host=toctoc-shell"

	echo "==================== sso ===================="
	docker build -t toctoc-login $PATH_FRONTEND/sso/toctoc-login/ -f $PATH_FRONTEND/sso/toctoc-login/dockerfile
	docker tag toctoc-login:latest $AWS_EKS/toctoc-login:latest
	docker push $AWS_EKS/toctoc-login:latest

	kubectl delete deploy/toctoc-login
	# kubectl delete service/toctoc-login
	kubectl apply -f $EXPORTS/qa/deploy/sso/toctoc-login.yaml
	# kubectl expose deployment toctoc-login --port=3001
	echo "success toctoc-login --port=3001 --host=toctoc-shell"

	echo "==================== ventas-frontend ===================="
	docker build -t ventas-frontend $PATH_FRONTEND/ventas/frontend/ -f $PATH_FRONTEND/ventas/frontend/dockerfile.qa
	docker tag ventas-frontend:latest $AWS_EKS/ventas-frontend:latest
	docker push $AWS_EKS/ventas-frontend:latest

	kubectl delete deploy/ventas-frontend
	# kubectl delete service/ventas-frontend
	kubectl apply -f $EXPORTS/qa/deploy/ventas/frontend.yaml 
	# kubectl expose deployment ventas-frontend --port=4500
	echo "success ventas-frontend --port=4500 --host=toctoc-shell"

	echo "==================== toctoc-server ===================="
	docker build -t toctoc-server $PATH_FRONTEND/toctoc/toctoc-server/ -f $PATH_FRONTEND/sso/toctoc-server/dockerfile.qa
	docker tag toctoc-server:latest $AWS_EKS/toctoc-server:latest
	docker push $AWS_EKS/toctoc-server:latest

	kubectl delete deploy/toctoc-server
	# kubectl delete service/toctoc-server
	kubectl apply -f $EXPORTS/qa/deploy/toctoc/toctoc-server.yaml
	# kubectl expose deployment toctoc-server --port=4999
	echo "success toctoc-server --port=4999 --host=toctoc-shell"

	echo "==================== portal-corredoras ===================="
	docker build -t portal-corredoras $PATH_FRONTEND/gestioncorredor/portal-corredoras/ -f $PATH_FRONTEND/gestioncorredor/portal-corredoras/dockerfile
	docker tag portal-corredoras:latest $AWS_EKS/portal-corredoras:latest
	docker push $AWS_EKS/portal-corredoras:latest

	kubectl delete deploy/portal-corredoras
	# kubectl delete service/portal-corredoras
	kubectl apply -f $EXPORTS/qa/deploy/portalcorredoras/portal-corredoras.yaml
	# kubectl expose deployment toctoc-server --port=3000
	echo "success portal-corredoras --port=3000 --host=toctoc-shell"

	echo "==================== urban-server ===================="
	docker build -t urban-server $PATH_FRONTEND/urbanCenter/urbanCenter-server/ -f $PATH_FRONTEND/urbanCenter/urbanCenter-server/Dockerfile
	docker tag urban-server:latest $AWS_EKS/urban-server:latest
	docker push $AWS_EKS/urban-server:latest

	kubectl delete deploy/urban-server
	# kubectl delete service/urban-server
	kubectl apply -f $EXPORTS/qa/deploy/urbanserver/urban-server.yaml
	# kubectl expose deployment urban-server --port=3000
	echo "success urban-server --port=3000 --host=toctoc-shell"

	echo "==================== nginx ===================="
	docker build -t nginx $NGINX/ -f $NGINX/dockerfile.qa
	docker tag nginx:latest $AWS_EKS/nginx:latest
	docker push $AWS_EKS/nginx:latest

	kubectl delete deploy/nginx
	# kubectl delete service/nginx
	kubectl apply -f $EXPORTS/qa/deploy/nginx.yaml
	# kubectl apply -f $EXPORTS/qa/service/nginx.yaml
	echo "success nginx --port=80 443 --host=toctoc-shell"

	echo "==============================================="

	echo "==================== CRONS ===================="

	kubectl delete cronjob carritoabandonado
	kubectl delete cronjob desactivarplanes
	kubectl delete cronjob destacadopropiedades
	kubectl delete cronjob enviorenovaciones
	kubectl delete cronjob correobienvenida
	kubectl delete cronjob oportunidades

	kubectl create -f $EXPORTS/qa/crons/gestioncorredor/cronjob-carrito-abandonado.yaml

	kubectl create -f $EXPORTS/qa/crons/gestioncorredor/cronjob-desactivar-planes.yaml

	kubectl create -f $EXPORTS/qa/crons/gestioncorredor/cronjob-destacado-propiedades.yaml

	kubectl create -f $EXPORTS/qa/crons/gestioncorredor/cronjob-envio-renovaciones.yaml

	kubectl create -f $EXPORTS/qa/crons/gestioncorredor/cronjob-correo-bienvenida.yaml

	kubectl create -f $EXPORTS/qa/crons/procesamiento/cronjob-oportunidades.yaml

	echo "==============================================="

echo "SUCCESS!"