# Custom Linux, Mango Linux

```bash
cd ~/Desktop
git clone https://github.com/MSM74588/mango-lb-test.git
cd mango-lb-test
sudo ./live-build.sh

sudo lb build

sudo lb clean

sudo lb clean && sudo ./live-build.sh && sudo lb build


cd ~/Desktop
git clone https://github.com/MSM74588/mango-lb-test.git
cd mango-lb-test
sudo lb config
sudo lb build
```
