FROM python:3.8

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y libgl1-mesa-glx libglib2.0-0 libsm6 libxrender1 libxext6 ffmpeg

ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt --use-feature=2020-resolver

COPY . /app
WORKDIR /app

EXPOSE 60001

CMD ["streamlit", "run", "app.py", "--server.port", "60001"]
