# Use official Ubuntu image
FROM ubuntu:latest

# Set environment variables to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install SSH server and necessary packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Generate SSH host keys (Required for SSH server to run)
RUN ssh-keygen -A

# Create user 'hero' and set password
RUN useradd -m hero && \
    echo "hero:hero123" | chpasswd && \
    adduser hero sudo

# Prepare SSH environment
RUN mkdir /var/run/sshd

# Set up .ssh folder for hero user
RUN mkdir -p /home/hero/.ssh && \
    chmod 700 /home/hero/.ssh && \
    touch /home/hero/.ssh/authorized_keys && \
    chmod 600 /home/hero/.ssh/authorized_keys && \
    chown -R hero:hero /home/hero/.ssh

# Switch to hero user
USER hero

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
