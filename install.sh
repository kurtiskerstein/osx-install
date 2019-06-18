#!/usr/bin/env bash

#Begin by installing Xcode from the App Store
#Check if Xcode is installed with xcode-select –p
#Install Command Line Tools via Xcode
xcode-select --install

#Install Homebrew, if not already installed
echo "alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'" >> ~/.bash_profile
source ~/.bash_profile

if [ ! $(which brew) ]; then
  echo "Installing Homebrew…"
  ruby -e "$(curl -fsSl https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
else
  echo "Updating and cleaning Homebrew…"
  brewup
fi


#Install GNU core utilities (those that come with OS X are outdated)
echo "Installing GNU core utilities…"
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names


#Install new Bash
echo "Installing new Bash…"
brew install bash bash-completion
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'


#Install and switch to Zsh
echo "Installing Zsh…"
brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting
sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'
chsh -s /usr/local/bin/zsh #Switch default shell to Zsh

#Add oh-my-zsh, theme, plugins, powerline fonts
#echo "Installing and configuring oh-my-zsh…"
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
#sed -i -e 's/  git/  colored-man-pages\n  git\n  python\n  sublime/g' ~/.zshrc

#Add basic Zsh configuration
#echo "Configuring Zsh…"
#echo -e 'source ~/.bash_profile\n' | cat - ~/.zshrc > temp && mv temp ~/.zshrc
#echo "export DEFAULT_USER=\`whoami\`" >> ~/.zshrc
#echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
#echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc


#Python time!
brew install pyenv direnv #pyenv-virtualenv
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshenv
echo -e 'if which direnv > /dev/null; then\n eval "$(direnv hook zsh";\nfi' >> ~/.zshenv
#echo -e 'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi' >> ~/.zshrc
exec "$SHELL"

#Type 'pyenv install -l' to see a list of available versions for install
#Installing the plugin below creates the ability to also use "pyenv install-latest".
#git clone https://github.com/momo-lab/pyenv-install-latest.git "$(pyenv root)"/plugins/pyenv-install-latest
#pyenv install-latest
# pyenv global x.x.x to set the global version of python.


#Install other binaries
binaries=(
  ack #'like grep, but optimized for programmers`
  git
  postgresql
  redis
  tmux
  tree
  vim
  wget
  sed
)

echo "Installing binaries..."
brew install ${binaries[@]}


#Install apps to /Applications
#Each has its own command to prevent errors in remaining installed if a piece of software is already installed (a cask design decision).
brew tap caskroom/versions
echo "Installing apps to /Applications…"
brew cask install --appdir="/Applications" iterm2
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" vagrant


#Clean up after Homebrew
echo "Cleaning up…"
brewup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*


#Set up OS tweaks
#echo "Tweaking OS settings…"

#Enable right click; logging out and back in is required to take effect
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
#defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
#defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

#Show hidden programs by default. Allows using ⌘+H to hide, and ⌘+Tab switching
#defaults write com.apple.Dock showhidden -bool TRUE
#killall Dock

#Remove Dock delay
#defaults write com.apple.Dock autohide-delay -float 0
#killall Dock

#Show hidden files by default
#defaults write com.apple.finder AppleShowAllFiles -bool TRUE
#killall Finder

#Show long path name on all folders
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
#killall Finder

#Show status bar
#defaults write com.apple.finder ShowStatusBar -bool true
#killall Finder

#Show file extensions in Finder
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true
#killall Finder

#Disable drop shadows on a screenshot
#defaults write com.apple.screencapture disable-shadow -bool TRUE
#killall SystemUIServer

# Check for macOS updates daily instead of weekly
#defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Prevent Apps From Saving to iCloud by Default
#defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool FALSE

#Enable debug menu
#defaults write com.apple.appstore ShowDebugMenu -bool true

#Change default text editor to Sublime Text 3
#If this command doesn't work, see http://ultimatemac.com/how-to-change-default-text-editor-on-mac/ for manual instructions
#defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
#'{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.sublimetext.3;}'


#Finished!
echo "Done!"

