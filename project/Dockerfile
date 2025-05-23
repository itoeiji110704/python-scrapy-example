FROM python:3.11.3-buster

USER root
RUN apt-get update && apt-get install -y sudo
RUN apt-get install -y tzdata && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt update -y
RUN apt install -y libatk1.0-0 fonts-ipafont unzip
RUN fc-cache -fv
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt --fix-broken install -y
RUN apt install -y fonts-liberation libasound2 libatk-bridge2.0-0 libatspi2.0-0 libcups2 libdbus-1-3 libdrm2 libgbm1 libgtk-3-0 libnspr4 libnss3 libvulkan1 libxcomposite1 libxdamage1 libxfixes3 libxkbcommon0 libxrandr2 xdg-utils xvfb
RUN Xvfb :99 -screen 0 1280x1024x24 &
ENV DISPLAY=:99
RUN dpkg -i google-chrome-stable_current_amd64.deb
RUN wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /usr/bin/chromedriver
RUN chown root:root /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver

ENV PATH $PATH:/home/jovyan/.local/bin
ENV PYTHONPATH $PYTHONPATH:/project

WORKDIR /project

RUN pip install -U pip
RUN pip install poetry==1.7.1
COPY poetry.lock pyproject.toml ./
RUN poetry config virtualenvs.create false && \
    poetry install

COPY ./ ./

CMD ["python", "main.py"]
