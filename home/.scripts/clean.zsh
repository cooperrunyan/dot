# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "Starting"
echo " "

echo "  Deleting .DS_Store files"
find ~ -type f -name '*.DS_Store' -ls -delete | echo

# Flush Directory Service cache
echo "  Flushing Directory Service cache"
dscacheutil -flushcache | echo

echo "  Empty the Trash on all volumes and device"
killall -HUP mDNSResponder
sudo rm -rfv /Volumes/*/.Trashes | echo
sudo rm -rfv ~/.Trash | echo

echo "  Clear System Logs to improve shell startup speed"
sudo rm -rfv /private/var/log/asl/*.asl | echo

echo "  Clear download history from quarantine" # https://mths.be/bum
sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent' | echo

echo "Done"
