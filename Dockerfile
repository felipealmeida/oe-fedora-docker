FROM fedora:26                                                                

# Upgrade system and Yocto Proyect basic dependencies
RUN yum groupinstall "development tools"
RUN yum -y install gawk make wget tar bzip2 gzip python unzip perl patch \
     diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath \
     ccache perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue socat \
     findutils which xterm glibc-locale-source glibc-langpack-en cpio file hostname \
     perl-bignum

# Set up locales
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.utf8

# User management                                                                
RUN groupadd -g 1000 build && useradd -u 1000 -g 1000 -ms /bin/bash build && usermod -a -G users build 

#&& usermod -a -G sudo build && 

# Install repo                                                                   
RUN curl -o /usr/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && chmod a+x /usr/bin/repo 
                                                                                 
# Run as build user from the installation path                                   
USER build

ENV MACHINE=hikey960
ENV DISTRO=rpb

# Make /home/build the working directory                                         
WORKDIR /home/build
