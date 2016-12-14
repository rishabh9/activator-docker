FROM ubuntu:latest
MAINTAINER Rishabh Joshi <rishabh@xola.com>

ENV DEBIAN_FRONTEND noninteractive
ENV ACTIVATOR_VERSION 1.3.12

RUN set -x \
&& apt-get -yq update \
&& apt-get -yq --no-install-recommends install software-properties-common unzip wget git \
&& apt-get -yq autoremove && apt-get -yq clean && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:webupd8team/java && apt-get -yq update \
&& echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
&& apt-get -yq --no-install-recommends install oracle-java8-installer oracle-java8-set-default \
&& apt-get -yq autoremove && apt-get -yq clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget -q --progress=dot:mega http://downloads.typesafe.com/typesafe-activator/$ACTIVATOR_VERSION/typesafe-activator-$ACTIVATOR_VERSION.zip \
&& unzip -qq typesafe-activator-$ACTIVATOR_VERSION.zip \
&& mv activator-dist-$ACTIVATOR_VERSION /opt/activator \
&& ln -s /opt/activator/bin/activator /usr/local/bin/activator \
&& rm -f typesafe-activator-$ACTIVATOR_VERSION.zip

RUN mkdir /home/app
ADD . /home/app
WORKDIR /home/app

EXPOSE 8888
EXPOSE 9000
EXPOSE 9999

ENTRYPOINT ["activator", "-Dhttp.address=0.0.0.0"]

# Default Command
CMD ["ui"]
