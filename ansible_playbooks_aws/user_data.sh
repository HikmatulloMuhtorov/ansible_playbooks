#!/bin/bash
sudo amazon-linux-extras install -y epel
sudo yum groupinstall "Development Tools" -y
sudo yum install openssl-devel libffi-devel bzip2-devel -y
gcc --version
sudo yum install wget -y
sudo mkdir -p /opt/python3.9/
sudo chown -R $USER:$USER /opt/python3.9/
wget https://www.python.org/ftp/python/3.9.9/Python-3.9.9.tgz -P /opt/python3.9
cd /opt/python3.9/
tar xvf Python-3.9.9.tgz
whoami
sudo chown -R $USER:$USER Python-3.9.9
cd Python-3.9.9/
ls -al
pwd
./configure --enable-optimizations
sudo make altinstall
python3.9 --version
pip3.9 --version
`;
    init.addConfig('install_python39', new ec2.InitConfig([
      ec2.InitFile.fromString('/opt/install_python39.sh', installPythonString, {
        mode: '000755',
        owner: 'root',
        group: 'root',
      }),
      ec2.InitCommand.shellCommand('sudo sh install_python39.sh', {
        cwd: '/opt',
        key: 'install_python39',
      }),
]))