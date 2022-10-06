import os
import requests
import xml.etree.ElementTree as ET
import config
from datetime import datetime, timedelta

def main():

    #env
    dir_name = os.path.dirname(__file__)
    rss_url = 'https://www.twreporter.org/a/rss2.xml'
    now = datetime.now()
    datetime_str = now.strftime('%Y%m%d%H%M%S').strip()
    xml_name = datetime_str + '.xml'
    xml_path = dir_name + '/rss_feed/' + xml_name
    txt_name = 'record.txt'
    txt_path = dir_name + '/' + txt_name
    post_url = 'https://g0v.social/api/v1/statuses'

    # get rss feed and store it at ./rss_feed/yyddmmHHMMSS.xml
    response = requests.get(rss_url)
    with open(xml_path, 'wb') as file:
        file.write(response.content)

    # get last post pubdate (record store in txt file)
    with open(txt_path, 'r') as file:
        latest_link = file.readline().strip()

    tree = ET.parse(xml_path)
    root = tree.getroot()
    feed_list = []
    
    # retrieve feed
    for item in root.iter('item'):
        time = datetime.strptime(item[4].text , '%a, %d %b %Y %H:%M:%S %Z')
        time = time + timedelta(hours=8)
        title = item[0].text.strip()
        description = item[1].text.strip()
        link = item[2].text.strip()
        feed = {'time': time, 'title': title, 'description': description, 'link': link}
        feed_list.append(feed)

    # post new feed in time sequence
    after_latest_link = False
    for feed in reversed(feed_list):
        if after_latest_link:
            toot = feed['title'] + '\n\n' + feed['description'] + '\n\n' + feed['link']
            data = {'status' : toot}
            headers = {'Authorization': 'Bearer ' + config.access_token}
            r = requests.post(post_url, data=data, headers=headers)
            json_data = r.json()
            # print(json_data)
        if feed['link'] == latest_link:
            after_latest_link = True

    # update latest_time to record.txt
    with open(txt_path, 'w') as file:
        latest_link = feed_list[0]['link'].strip()
        file.write(latest_link + '\n')

if __name__ == '__main__':
    main()
