Typesafe Activator For Docker
================
Activator is the Typesafe Reactive Platform's build and tutorial tool. It allows you to easily get started with Play Framework, Akka and Scala.

This build is configured to use version 1.3.12 of Activator and Oracle JDK 8.

How to run
----------
First of all, pull the image using 

    [sudo] docker pull rishabh9/activator

Once you have downloaded the image, you can start a new activator container as follows:

    [sudo] docker run -it --name my_container_name -v /my/source/directory:/home/app -p 9000:9000 rishabh9/activator run

This will create a container called 'my_container_name' that runs the code from /my/source/directory. You will be able to access the application using port 9000 on your host machine.

You can replace the 'run' command at the end by any other Activator command such as 'test' or 'ui'.

Notice that your code directory is mapped to '/home/app'. As can be seen from the Dockerfile, this is the working directory of this build from which Activator will run.

Running Activator UI
--------------------
Activator provides a web interface where you can find a great set of tutorials to help you get started with the Play Framework, Akka, Scala...

In order to access this interface, simply create a container using the following command:

    [sudo] docker run -it -p 8888:8888 rishabh9/activator
    
This will automatically start up the web interface on port 8888 of your host machine. Notice that you don't need to specify the '/home/app' mapping.


Speeding up startup times
-------------------------
When running this image, you will notice that it takes a long time to start up because Activator is building up the dependencies for your project. If you want to ensure that you only go through this process once (or only on a change of dependencies), you can add a Docker Data Container that mounts the necessary cache folders. You can create the data container using the following command:

     docker pull busybox
     [sudo] docker run -it --name activator_cache -v /root/.ivy2 -v /root/.sbt busybox /bin/sh
     
You can then add this data container when running the Activator image:

    [sudo] docker run -it --name my_container_name -v /my/source/directory:/home/app --volumes-from activator_cache -p 9000:9000 rishabh9/activator run
    
Notice that by adding '--volumes-from activator_cache', the two cache folders will not be destroyed when the container is stopped, and therefore, startup times will go substantially faster.

Although this might not be optimal for production use, it can definitely speed up development.
