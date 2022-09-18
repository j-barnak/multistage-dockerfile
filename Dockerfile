## Debug Section of Build
## Note: You will need to run :PlugInstall in ~/.vimrc and remove the comments in ~/.vim/coc-settings.json
FROM ubuntu AS debug

# no interactive session is used during docker build
ENV DEBIAN_FRONTEND="noninteractive"

# Install necessary pacakges
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y clangd git build-essential gdb cgdb wget vim valgrind curl

# Set up vim environment
RUN mkdir ~/.vim
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Get vimrc
RUN cd && git clone https://github.com/j-barnak/vimrc.git 
RUN mv ~/vimrc/coc-settings.json ~/.vim
RUN mv ~/vimrc/.vimrc ~/ 
RUN rm -rf ~/vimrc

# Install nvm with node and npm
# Installing Node
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
RUN source /root/.bashrc && nvm install --lts
SHELL ["/bin/bash", "--login", "-c"]

# Project Specific
# Any install you need for a project, put them here

## To build, do: docker build . --target debug -t <tag name>
## To run, do: docker run --rm -it --entrypoint bash <tag name>
## MULTI STAGE  ##
# When you are ready for the release build, copy only the necessary files from the debug build here
# FROM <image> AS release
