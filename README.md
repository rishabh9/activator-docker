Typesafe Activator For Docker
================
This build is configured to use Activator v1.3.12 and OpenJDK 8.

How to run
----------
First of all, pull the image using 

    [sudo] docker pull rishabh9/activator

Once you have downloaded the image, you can start a new activator container as follows:

    [sudo] docker run -it --rm -v /my/source/directory:/home/app -v sbt:/root/.sbt -v ivy2:/root/.ivy2 -p 9000:9000 rishabh9/activator run

This will create a container that runs the code from /my/source/directory. You will be able to access the application using port 9000 on your host machine.

You can replace the 'run' command at the end by any other Activator command such as 'test' or 'ui'.

Notice that your code directory is mapped to '/home/app'. As can be seen from the Dockerfile, this is the working directory of this build from which Activator will run.

Running Activator UI
--------------------
Activator provides a web interface where you can find a great set of tutorials to help you get started with the Play Framework, Akka, Scala...

In order to access this interface, simply create a container using the following command:

    [sudo] docker run -it -p 8888:8888 rishabh9/activator
    
This will automatically start up the web interface on port 8888 of your host machine. Notice that you don't need to specify the '/home/app' mapping.

