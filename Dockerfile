# Use official Ubuntu image
FROM ubuntu:latest

# Set environment variables to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install SSH server and other necessary packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a new user 'hero' and set password
RUN useradd -m hero && \
    echo "hero:hero123" | chpasswd && \
    adduser hero sudo

# Configure SSH to allow root login (optional) and enable SSH service
RUN mkdir /var/run/sshd

# Create .ssh directory for the user and add a public key (optional for key-based authentication)
RUN mkdir -p /home/hero/.ssh && \
    chmod 700 /home/hero/.ssh && \
    touch /home/hero/.ssh/authorized_keys && \
    chmod 600 /home/hero/.ssh/authorized_keys && \
    chown -R hero:hero /home/hero/.ssh

# Change the default user to 'hero'
USER hero

# Expose port 22 for SSH access
EXPOSE 22

# Start SSH service and keep the container running
<<<<<<< HEAD
CMD ["/usr/sbin/sshd", "-D"]
=======
CMD ["/usr/sbin/sshd", "-D"]
>>>>>>> 810eb6a (updated files)
