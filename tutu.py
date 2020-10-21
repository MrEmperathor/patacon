import tus

FILE_PATH = 'tes5.mp4'
TUS_ENDPOINT = 'https://upload299.fvs.io/upload/'
HEADERS = {'Upload-Metadata': 'token  blhUUUNYais4L1UrVllyZVluYnRhNktFYmF5Mnd0V1NyZVd4T2JKbk5mZGNTTHdPUi9HOXAyMzZjT1RUWG9lNW56MEQzTTJYTDBVVWxlYXh3QT09OmdkWG1WMzFuMTVGOHNFNmNKOXFQVFE9P, name dGVzNS5tcDQ='}
CHUNK_SIZE = 256000

with open(FILE_PATH, 'rb') as f:
    tus.upload(
    	f,
        TUS_ENDPOINT,
        headers=HEADERS,
        chunk_size=CHUNK_SIZE)
