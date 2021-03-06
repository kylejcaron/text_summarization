#!/bin/bash

# Record starting time
touch $HOME/.bootstrap-begin

sudo yum -y update
sudo yum -y install tmux

# Create the anaconda directory on a volume with more space
sudo mkdir /mnt/anaconda
sudo chown hadoop:hadoop /mnt/anaconda
ln -s /mnt/anaconda $HOME/anaconda

# Create the nltk_data directory on a volume with more space
sudo mkdir /mnt/nltk_data
sudo chown hadoop:hadoop /mnt/nltk_data
sudo ln -s /mnt/nltk_data /usr/share/nltk_data
sudo chown hadoop:hadoop /usr/share/nltk_data
# Clone git repo
sudo yum -y install git
git clone https://github.com/kylejcaron/text_summarization.git

# Download Anaconda
wget -S -T 10 -t 5 https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh -O $HOME/anaconda/anaconda.sh

# Install Anaconda
bash $HOME/anaconda/anaconda.sh -u -b -p $HOME/anaconda

# Add Anaconda to current session's PATH
export PATH=$HOME/anaconda/bin:$PATH

# Add Anaconda to PATH for future sessions via .bashrc
echo -e "\n\n# Anaconda" >> $HOME/.bashrc
echo "export PATH=$HOME/anaconda/bin:$PATH" >> $HOME/.bashrc

# Download NLTK libraries
$HOME/anaconda/bin/python -c "import nltk; \
nltk.download('stopwords', '/usr/share/nltk_data'); \
nltk.download('punkt', '/usr/share/nltk_data'); \
nltk.download('averaged_perceptron_tagger', '/usr/share/nltk_data'); \
nltk.download('maxent_treebank_pos_tagger', '/usr/share/nltk_data')"

# Record ending time
touch $HOME/.bootstrap-end
