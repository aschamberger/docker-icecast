# aschamberger/icecast

http://icecast.org/

## Usage

```
docker create \
	--name=Icecast \
	-v <path to data>:/config \
	-e USER_ID=<uid> -e GROUP_ID=<gid> -e UMASK=<umask> \
	-p 8000:8000 \
	aschamberger/icecast
```

## Parameters

* `-v /config` - icecast data (config/logs)
* `-e USER_ID` - match UID of user *nobody* of host system
* `-e GROUP_ID` - match GID of group *users* of host system
* `-e UMASK` - match UMASK of host system
* `-p 8000` - icecast port
