from tusclient import client

# Establecer encabezados de autorización si es necesario
# by the tus server.
my_client = client.TusClient('http://master.tus.io/files/',
                              headers={'Authorization': 'Basic xxyyZZAAbbCC='})

# set more headers
my_client.set_headers({'HEADER_NAME': 'HEADER_VALUE'})

uploader = my_client.uploader('path/to/file.ext', chunk_size=200)

# También se puede pasar una secuencia de archivo en lugar de una ruta de archivo.
fs = open('path/to/file.ext')
uploader = my_client.uploader(file_stream=fs, chunk_size=200)

# upload a chunk i.e 200 bytes
uploader.upload_chunk()

# uploads the entire file.
# This uploads chunk by chunk.
uploader.upload()

# you could increase the chunk size to reduce the
# number of upload_chunk cycles.
uploader.chunk_size = 800
uploader.upload()

# Continue uploading chunks till total chunks uploaded reaches 1000 bytes.
uploader.upload(stop_at=1000)


