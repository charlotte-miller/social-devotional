## Requirements

### Utility
- [HandBrake](http://handbrake.fr/downloads2.php) | [\[docs\]](https://trac.handbrake.fr/wiki/CLIGuide)
- ffmpeg ``brew install ffmpeg --with-libvpx --with-libvorbis``
- [qtfaststart](https://github.com/danielgtaylor/qtfaststart) [WARNING] passing this an mp3 almost bricked my mac


## Spike
https://gist.github.com/JamesDullaghan/5941259
sudo nano /etc/ssh/sshd_config
PermitRootLogin no

https://www.digitalocean.com/community/articles/how-to-add-swap-on-ubuntu-12-04
sudo dd if=/dev/zero of=/swapfile bs=1024 count=512k
sudo mkswap /swapfile
sudo swapon /swapfile
CHECK with sudo swapon -s
sudo nano /etc/fstab
PASTE  /swapfile       none    swap    sw      0       0 
echo 0 | sudo tee /proc/sys/vm/swappiness
echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
sudo chown root:root /swapfile 
sudo chmod 0600 /swapfile

sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:rwky/redis
sudo apt-get update
sudo apt-get install -y curl tree htop
sudo apt-get install -y git-core
sudo apt-get install -y redis-server
sudo apt-get install -y ffmpeg
cat ~/.ssh/id_rsa.pub | ssh -p 22 username@123.123.123.123 'cat >> ~/.ssh/authorized_keys'

ssh-keygen -t rsa #generate ssh key
add deployment key to bitbucket.com https://bitbucket.org/chip_miller/social-devotional/admin/deploy-keys
add ssh key to github.com https://github.com/settings/ssh
test by cloning code and bundling

[TUTORIAL]
Did you edit nginx's config to point to /home/app/demo/current as well? 
It's in /etc/nginx/sites-enabled

Modify Configuration in Unicorn 

/home/unicorn - > unicorn.confg 

user "rails" 
working_directory "/home/rails" 


etc/default/unicorn 

APP_ROOT=/home/rails 

https://www.digitalocean.com/community/articles/how-to-1-click-install-ruby-on-rails-on-ubuntu-12-10-with-digitalocean 
[TUTORIAL]

<!-- sudo rvm implode
cd /tmp
wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p353.tar.gz
tar -xvzf ruby-2.0.0-p353.tar.gz
cd ruby-2.0.0-p353/
./configure --prefix=/usr/local
make
sudo make install
gem install bundler --no-ri --no-rdoc -->


sudo chown -R chip /var/www/
(local) be cap deploy:setup
(local) be cap deploy:cold

bundle the shared/cached-copy

redis
ffmpeg
solr
