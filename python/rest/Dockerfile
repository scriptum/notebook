FROM python:alpine

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY todo.py .

EXPOSE 5000

CMD [ "python", "/todo.py" ]
