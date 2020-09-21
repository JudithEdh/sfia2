#Use Python Image
FROM python:3.7
WORKDIR /app
# Install apt dependencies
RUN apt-get update && apt-get install -y python3-pip 
# Copy contents into image
COPY . .
# run pip dependencies
RUN pip3 install Flask Flask-SQLAlchemy PyMySQL
# Expose correct port
EXPOSE 5000
# Create an entrypoint
ENTRYPOINT ["/usr/local/bin/python3", "app.py"]
