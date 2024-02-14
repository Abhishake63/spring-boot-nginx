# Scaling Spring Boot: A Guide to Efficient Deployment with Docker and Nginx Load Balancer

Welcome to the Spring Boot "Nginx" project! This is a simple project that demonstrates the way of scaling a Spring Boot Application using Nginx as a Load Balancer.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Dockerizing the Project](#dockerizing-the-project)
- [Editing Nginx Config](#editing-nginx-config)
- [Check if Nginx Load Balancer is Working](#check-if-nginx-load-balancer-is-working)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project serves as a starting point for understanding how to scale a basic Spring Boot application using Docker for Containerization and Nginx for Load Balancing. It includes the necessary setup and dependencies to quickly get you up and running.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Java Development Kit (JDK) installed (version 17 or higher)
- Maven build tool installed
- Nginx, Docker installed

## Dockerizing the Project

### Dockerfile

```docker
FROM eclipse-temurin:17-alpine
RUN mkdir /opt/app
COPY target/*.war /opt/app/app.war
ENTRYPOINT ["java", "-jar", "/opt/app/app.war"]
```

### **Build the WAR file**

```bash
mvn clean package
```

### **Build the Docker image**

```bash
docker build -t nginx .
```

> Go to the project directory and run these above commands
>

### **Run the Docker container**

```bash
docker run -d -p 1111:8080 nginx:latest
docker run -d -p 2222:8080 nginx:latest
docker run -d -p 3333:8080 nginx:latest
```

> Run 3 containers with the Docker image
>

## Editing Nginx Config

```
http {

	include mime.types;

	upstream backendserver {
		server localhost:1111;
		server localhost:2222;
		server localhost:3333;
	}

	server {
		listen 8080;

		location / {
			proxy_pass http://backendserver/;
		}
	}
}

events {}
```

> Go to `/etc/nginx` & edit `nginx.conf` file with the above config & restart `nginx`
>

## Check if Nginx Load Balancer is Working

```bash
curl http://localhost:8080/check
```

> Check if the response contains different container identifiers.
>
>
> By combining these steps, you should be able to determine whether `Nginx` is successfully `round-robin distributing requests` among your Spring Boot containers.
>

## Contributing

Contributions are welcome! If you'd like to contribute to this project, follow these steps:

1. Fork the project from the GitHub repository.
2. Create a new branch with a descriptive name.
3. Make your desired changes.
4. Commit and push your changes to your fork.
5. Create a pull request detailing your changes.

## License

This project is licensed under the [MIT License](LICENSE).

---

Happy coding!

For more information about Spring Boot, visit the [official documentation](https://spring.io/projects/spring-boot).