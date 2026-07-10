# In this scenario, you'll be preparing the control plane node for installing a kubeadm Kubernetes cluster
# download the release binary
wget https://github.com/containerd/containerd/releases/download/v2.2.0/containerd-2.2.0-linux-amd64.tar.gz

# extract the binaries into /usr/local/bin, placing executables like containerd, ctr, containerd-shim-runc-v2, and containerd-stress in that location
sudo tar Cxzvf /usr/local containerd-2.2.0-linux-amd64.tar.gz

# create a symbolic link from /usr/local/bin/containerd to /usr/local/sbin/containerd
# This symlink ensures that containerd can be found in /usr/local/sbin, which is where some systemd service files or init systems might expect to find the containerd daemon binary.
sudo ln -sf /usr/local/bin/containerd /usr/local/sbin/containerd
#Configure systemd units for containerd
cat <<'EOF_UNIT' | sudo tee /etc/systemd/system/containerd.service
[Unit]
Description=containerd container runtime
Documentation=https://containerd.io
After=network.target

[Service]
ExecStart=/usr/local/bin/containerd
Restart=always
RestartSec=5
RuntimeDirectory=containerd
Delegate=yes
KillMode=process
OOMScoreAdjust=-999

[Install]
WantedBy=multi-user.target
EOF_UNIT
# Reload systemd and start containerd:

sudo systemctl daemon-reload
sudo systemctl enable --now containerd
# Verify the service:

sudo systemctl status containerd --no-pager

# Set the following parameters:

# Set sysctl -w net.ipv4.ip_forward equal to 1

# Set net.bridge.bridge-nf-call-iptables equal to 1