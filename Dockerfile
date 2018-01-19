FROM ubuntu:16.04

ADD ./environment.yml .

RUN apt-get update
RUN apt-get install -y build-essential cmake redis-server git qt5-default qt5-qmake curl
RUN apt-get install -y libyaml-cpp-dev libpqxx-dev libboost-dev libblas-dev liblapack-dev
RUN apt-get install -y libopenblas-base libboost-python-dev libsuperlu4
RUN git clone --recursive https://github.com/Cylix/cpp_redis.git && cd cpp_redis && git submodule init && git submodule update && mkdir build && cd build && cmake .. && make && make install && cd .. && cd tacopie && cmake . && make install
RUN curl --silent -o miniconda-installer.sh https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh && bash miniconda-installer.sh -b -p $HOME/anaconda3 && export PATH="$HOME/anaconda3/bin:$PATH" && echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> /root/.bashrc
RUN $HOME/anaconda3/bin/conda env create
#
