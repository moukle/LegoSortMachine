FROM python:3.9.16-bullseye

RUN apt update  --yes

WORKDIR /lego

# LDView
ENV LD_FILE ldview-qt5-4.5-debian-bullseye.amd64.deb
RUN wget https://github.com/tcobbs/ldview/releases/download/v4.5/$LD_FILE && \
    apt install --yes desktop-file-utils && \
    apt install --yes ./$LD_FILE

# LDraw parts
RUN wget https://www.ldraw.org/library/updates/complete.zip && \
    mkdir -p /ldraw/parts && \
    unzip complete.zip -d /ldraw/parts

# install dependencies
ADD ./BrickScanner/requirements.txt ./src/
RUN pip install --upgrade pip
RUN pip install -r ./src/requirements.txt

# start in correct dir with x11docker
RUN echo "cd /lego/src" >> /etc/bash.bashrc

RUN apt install --yes fish mpv

CMD fish