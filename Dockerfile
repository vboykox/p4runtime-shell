FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]
ENV PKG_DEPS python3 python3-pip git

RUN apt-get update && \
    apt-get install -y --no-install-recommends $PKG_DEPS && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*

COPY . /p4runtime-sh/
WORKDIR /p4runtime-sh/

RUN pip3 install --upgrade pip && \
    pip3 install --upgrade setuptools

# install latests p4runtime proto
RUN cd /tmp && git clone https://github.com/p4lang/p4runtime && \
    cd p4runtime/py && python3 setup.py install && \
    cd - && \
    rm -fr p4runtime

RUN python3 setup.py install

RUN mkdir /user-data/

WORKDIR /user-data/

ENTRYPOINT ["bash"]
