# meteor-centos7

FROM openshift/base-centos7

# Put the maintainer name in the image metadata
MAINTAINER Daniel Secik <secikd@mzk.cz>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building meteor apps" \
      io.k8s.display-name="builder meteor" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,meteor"

# Install required packages here:
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -
#RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -
RUN yum install -y nodejs
#RUN sudo apt-get install -y nodejs
#RUN yum install -y epel-release nodejs npm && yum clean all -y

RUN curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh


# This default user is created in the openshift/base-centos7 image
USER 1001




# TODO (optional): Copy the builder files into /opt/app-root
#COPY ./<builder_folder>/ /opt/app-root/

# Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
#RUN chown -R 1001:1001 /opt/app-root

# Set the default port for applications built using this image
EXPOSE 3000

# Set the default CMD for the image
CMD ["usage"]

