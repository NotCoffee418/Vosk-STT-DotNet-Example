# Vosk STT Example
This is a scrapped project with fully implemented:
- Vosk STT
- DotEnv config for c#
- Model download script

Using the largest model (3.75GB extracted) it uses 12GB ram. There are more [lightweight models](https://alphacephei.com/vosk/models).  

**Good**
- It just works
- On a lightweight model it's probably lightweight
- Easy to use (nuget package)

**Bad**
- It's not super accurate on the best model, misses some obvious words
- seems to cut off the last chunk of text (can be manually fixed through partial interpretation)


## Dev
```ps1
./setup-windows.ps1
docker-compose -f docker-compose.dev.yml up
```

## Production
```bash
git clone https://github.com/NotCoffee418/vod-summary.git
cd vod-summary
./setup-linux.sh
docker compose up
```