start-server:
	cd server && ./mvnw spring-boot:run

start-client:
	cd client && flutter run -d chrome
	
run-dev:
	make start-server & make start-client