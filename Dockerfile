# meteor-centos7
FROM openshift/base-centos7

# Put the maintainer name in the image metadata
MAINTAINER Srisaiyeegharan Kidnapillai <srisaiyeegharan@gmail.com>

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building meteor apps" \
      io.k8s.display-name="builder meteor" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,meteor"

# Install the latest Node version
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs

# This default user is created in the openshift/base-centos7 image
USER 1001

# Install Meteor
RUN curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh

# Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/libexec/s2i

# Set the default port for applications built using this image
EXPOSE 3000

# Set the default CMD for the image
CMD ["usage"]
