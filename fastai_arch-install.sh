#!/usr/bin/zsh
#Scripts inspired by .fastai scripts for setup :git@github.com:fastai/courses.git
#Made them for myself to auto-install on my arch linux machine.
#I might have a setup a little different than yours so things might not work for you
# Pull requests welcome.  
sudo pacman -S tmux cudnn
pacaur -y anaconda cuda python-theano python-keras
echo "export PATH=\"/opt/anaconda/bin:\$PATH\"" >> ~/.profile
sudo conda install -y bcolz
sudo conda upgrade -y --all

echo "[global]
device = gpu
floatX = float32
[cuda]

root = /usr/local/cuda" > ~/.theanorc

mkdir ~/.keras
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json


# configure jupyter and prompt for password
jupyter notebook --generate-config
jupass=`python -c "from notebook.auth import passwd; print(passwd())"`
echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py

# clone the fast.ai course repo and prompt to start notebook
cd ~
git clone https://github.com/fastai/courses.git
echo "\"jupyter notebook\" will start Jupyter on port 8888"
echo "If you get an error instead, try restarting your session so your $PATH is updated"
