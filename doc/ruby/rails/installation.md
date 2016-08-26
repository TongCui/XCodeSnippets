[Getting Started with Rails](http://guides.rubyonrails.org/getting_started.html)

ruby -v

gem install rails


[Installing RVM](https://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/)

# Home Brew
brew doctor

echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# Gem

However, because RVM installs documentation for every gem that Rails depends on, which takes forever, I recommend disabling documentation first:

echo "gem: --no-document" >> ~/.gemrc

# RVM

curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --autolibs=enable --rails

rvm -v

ruby -v

update ruby

# Ruby versions

rvm reinstall 2.2.0 --disable-binary

rails -v

tcui:rails tcui$ rvm list rubies

rvm rubies

   ruby-2.2.0 [ x86_64 ]
=* ruby-2.3.0 [ x86_64 ]
   ruby-2.3.1 [ x86_64 ]

# => - current
# =* - current && default
#  * - default

tcui:rails tcui$ 

rvm use 2.2.0 --default

