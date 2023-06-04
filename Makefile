start-server:
	cd server && ./mvnw spring-boot:run

start-client:
	cd client && flutter run -d chrome --web-port 54735
	
run-dev:
	make start-server & make start-client