############################################################
# Dockerfile to build 
# Based on https://github.com/buchen/portfolio
FROM [user.id]/[parent.repository][parent.tag]

###########################################################
# File Author / Maintainer
MAINTAINER [user.name] "[user.email]"
################## BEGIN INSTALLATION ######################
USER root
RUN /bin/bash -c "apt-get update && apt-get upgrade -y && apt-get clean && apt-get autoremove"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install git
ENV USER_EMAIL "you@example.com"
ENV USER_NAME "Your Name"
RUN git config --global user.email $USER_EMAIL
RUN git config --global user.name $USER_NAME

ENV MAVEN_OPTS="-Xmx1g"

ADD mvnCleanInstall.sh /usr/bin
RUN chmod 755 /usr/bin/mvnCleanInstall.sh
RUN ln -s /data/portfolio/portfolio-product/target/products/name.abuchen.portfolio.product/linux/gtk/x86_64/portfolio/PortfolioPerformance /usr/bin/PortfolioPerformance
WORKDIR /data/portfolio/portfolio-app
USER user
CMD /opt/eclipse/eclipse -data /data/workspace
