import requests
from datetime import datetime

#env
rss_url = 'https://www.twreporter.org/a/rss2.xml'

def main():
    now = datetime.now()
    datetime_str = now.strftime('%Y%m%d%H%M%S')
    file_name = datetime_str + '.xml'
    response = requests.get(rss_url)
    with open('./rss_feed/' +  file_name, 'wb') as file:
        file.write(response.content)

if __name__ == '__main__':
    main()
