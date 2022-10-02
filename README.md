# Read The Reporter Bot

Posting latest The Reporter(報導者) article links at Mastodon instance.

Now hosted on **g0v.social**. Welcome to follow the bot at https://g0v.social/@read_tw_reporter_bot

## Deploy the bot

1. Download the source code
2. Execute `build.sh` to create essential file, create python vnev and make `.sh` file executable.
3. Add your `access_token` into `config.py`
4. Start python venv by typing `source ./bot_vnev/bin/activate`
5. Now the bot is ready on your machine. It can be activated through `python bot.py`
6. Add the cronjob setting in `cron` file.
