# build
FROM maven:3-openjdk-11

WORKDIR /usr/src/app
COPY pom.xml .
COPY src .
RUN mvn -B -e -C -T 1C org.apache.maven.plugins:maven-dependency-plugin:3.1.2:go-offline
COPY . .
RUN mvn -B -e -o -T 1C verify

# package without maven
FROM openjdk:13
COPY --from=0 /usr/src/app/target/consoleApp-1.0-jar-with-dependencies.jar ./
CMD "java" "-jar" "consoleApp-1.0-jar-with-dependencies.jar"