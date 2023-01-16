FROM puckel/docker-airflow:1.10.9

USER root

RUN set -ex \
   && buildDeps=' \
        freetds-dev \
        libkrb5-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        libpq-dev \
        git \
    ' \
   && apt-get update -yqq \
   && apt-get upgrade -yqq \
   && apt-get install -yqq --no-install-recommends \
        $buildDeps \
        freetds-bin \
        build-essential \
        default-libmysqlclient-dev \
        apt-utils \
        curl \
        rsync \
        netcat \
        locales \
        vim \
        iputils-ping \
   && sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
   && locale-gen \
   && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
   && apt-get install telnet \
   && apt-get install sudo -y \ 
   && apt install net-tools \ 
   && apt-get purge --auto-remove -yqq $buildDeps \
   && apt-get autoremove -yqq --purge \
   && apt-get install -y iputils-ping \ 
   && apt-get clean \
   && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base
   
RUN pip install vmwc \
   && pip install ldap3 \
   && pip install pywinrm \
   && pip install pymongo==3.12.1 \ 
   && pip install pythonping \
   && pip install -U pip setuptools wheel \
   && pip install pytz \
   && pip install pyOpenSSL \
   && pip install ndg-httpsclient \
   && pip install pyasn1 
   
EXPOSE 8080 5555 8793 27017 8081

USER airflow