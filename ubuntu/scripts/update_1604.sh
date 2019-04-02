#!/bin/bash
# Update the box
# Check whether dpkg process is running?
sleep 240
echo "=========end sleeep and start while true===================="
while true; do
  dpkg=`ps -ef | grep -v grep | grep "dpkg\|apt" | wc -l`
  if [ $dpkg != 0 ]; then
    sleep 30
  else
    while true; do
      dpkg=`ps -ef | grep -v grep | grep "dpkg\|apt" | wc -l`
      if [ $dpkg != 0 ]; then
        echo "Some dpkg processes are still running"
        # ps -ef | grep -v grep | grep "/usr/bin/dpkg"
        sleep 10
      else
        break
      fi
    done
    break
  fi
done
dpkg --configure -a
echo "========== Update repo cache =========="
apt-get -y update
sleep 2

echo "========== Upgrade packages =========="
apt-get -o Dpkg::Options::="--force-confold" -y upgrade

sleep 2

#apt-get install software-properties-common -y --reinstall
echo "========== Add ansible repo =========="
apt-add-repository ppa:ansible/ansible -y

sleep 2
echo "========== Update repo cache =========="
apt-get update -y 

sleep 2

echo "========== Install ansible =========="
apt-get install ansible -y 
#apt-get clean
#apt-get install -y --no-install-recommends vim curl byobu qemu-guest-agent python-dev build-essential python-configobj python-setuptools

cat << EOF > /etc/ansible/hosts
[local]
127.0.0.1
EOF

exit 0

