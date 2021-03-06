#!/bin/bash

# Script to setup a Ubuntu 16.04 to use FastPhotoStyle from Nvidia (https://github.com/NVIDIA/FastPhotoStyle)
# (requires a Nvidia GPU that supports CUDA 9.1)

# How to use :
# wget https://github.com/micodeyt/FastPhotoStyle/edit/master/setup.sh
# bash -i setup.sh
# (can take a while)
# source ~/.bashrc

# Anaconda and FastPhotoStyle folders will be in your home folder

#CUDA 9.1

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
rm cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt update 
sudo apt-get install cuda -y


#Anaconda3

curl -O https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh -b -f
rm Anaconda3-5.0.1-Linux-x86_64.sh

echo "export ANACONDA=/home/$(who -m | awk '{print $1;}')/anaconda3" >> ~/.bashrc
echo "export CUDA_PATH=/usr/local/cuda" >> ~/.bashrc
echo "export PATH=\${ANACONDA}/bin:\${CUDA_PATH}/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\${ANACONDA}/lib:\${CUDA_PATH}/bin64:\$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export C_INCLUDE_PATH=\${CUDA_PATH}/include" >> ~/.bashrc

source ~/.bashrc


#Additional dependencies

sudo apt install -y python3-pip python-pip

sudo apt-get install -y axel imagemagick
conda install pytorch=0.4.0 torchvision cuda91 -y -c pytorch
pip install scikit-umfpack
pip install -U setuptools
pip install cupy
pip install pynvrtc
pip install numpy
conda install -c -y menpo opencv3

#FastPhotoStyle repository with ade20k_ssn segmentation

cd ~

git clone https://github.com/midm/FastPhotoStyle.git
cd FastPhotoStyle
git clone https://github.com/midm/segmentation-pytorch segmentation
cd segmentation
./demo_test.sh
